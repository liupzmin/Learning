// Command rollctl
package main

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"

	"gopkg.in/alecthomas/kingpin.v2"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
	"k8s.io/client-go/util/retry"
	//
	// Uncomment to load all auth plugins
	// _ "k8s.io/client-go/plugin/pkg/client/auth"
	//
	// Or uncomment to load specific auth plugins
	// _ "k8s.io/client-go/plugin/pkg/client/auth/azure"
	// _ "k8s.io/client-go/plugin/pkg/client/auth/gcp"
	// _ "k8s.io/client-go/plugin/pkg/client/auth/oidc"
	// _ "k8s.io/client-go/plugin/pkg/client/auth/openstack"
)

func main() {

	home := homedir.HomeDir()

	config := "config"

	if runtime.GOOS == "windows" {
		config = "config.txt"
	}

	// Set the command line Flag
	var (
		app        = kingpin.New("rollctl", "A command-line roll upgrade in k8s.")
		kubeconfig = app.Flag("kubeconfig", "(optional) absolute path to the kubeconfig file").Short('f').Default(filepath.Join(home, ".kube", config)).String()
		namespace  = app.Flag("namespace", "(optional) the k8s namespace.").Short('n').Default("default").String()

		deploy      = app.Command("deploy", "manage all deployments in the namespace.")
		listDeploy  = deploy.Command("list", "list all deployments in the namespace.")
		rollDeploy  = deploy.Command("update", "roll upgrade deployment that have been provided.")
		deployName  = rollDeploy.Arg("name", "list or update.").Required().String()
		deployImage = rollDeploy.Arg("image", "image, such as 'nginx:1.13'.").Required().String()

		statefulSet = app.Command("state", "manage all statefulsets in the namespace.")
		listState   = statefulSet.Command("list", "list all stateful sets in the namespace.")
		rollState   = statefulSet.Command("update", "roll upgrade  stateful set that have been provided.")
		stateName   = rollState.Arg("name", "list or update.").Required().String()
		stateImage  = rollState.Arg("image", "image, such as 'nginx:1.13'.").Required().String()
	)

	app.Version("Version: 0.2.2")
	cmd := kingpin.MustParse(app.Parse(os.Args[1:]))

	clientset, err := getClient(*kubeconfig)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Get client error:  %s.\n", err.Error())
	}

	switch cmd {

	// list deployments
	case listDeploy.FullCommand():

		deploymentList, err := clientset.AppsV1().Deployments(*namespace).List(metav1.ListOptions{})

		if err != nil {
			fmt.Fprintf(os.Stderr, "List deployments error:  %s.\n", err.Error())
		}

		fmt.Printf("%-50s%-5s%-10s%-30s\n", "Name", "Redy", "UpToDate", "image")
		for _, d := range deploymentList.Items {

			fmt.Printf("%-50s%-5d%-10d%-30s\n", d.Name, d.Status.ReadyReplicas,
				d.Status.UpdatedReplicas, d.Spec.Template.Spec.Containers[0].Image)

		}
	// rolling a deployment
	case rollDeploy.FullCommand():

		err = rollingDeploy(clientset, *namespace, *deployName, *deployImage)

		if err != nil {
			fmt.Printf("update deployment %s error: %s \n", *deployName, err.Error())
		}

	// list statefulsets
	case listState.FullCommand():

		statefulsetList, err := clientset.AppsV1().StatefulSets(*namespace).List(metav1.ListOptions{})

		if err != nil {
			fmt.Fprintf(os.Stderr, "List statefulsets error:  %s.\n", err.Error())
		}

		fmt.Printf("%-50s%-5s%-10s%-30s\n", "Name", "Redy", "UpToDate", "Image")
		for _, s := range statefulsetList.Items {

			fmt.Printf("%-50s%-5d%-10d%-30s\n", s.Name, s.Status.ReadyReplicas,
				s.Status.UpdatedReplicas, s.Spec.Template.Spec.Containers[0].Image)

		}
	// rolling a statefulset
	case rollState.FullCommand():

		err = rollingStateful(clientset, *namespace, *stateName, *stateImage)

		if err != nil {
			fmt.Printf("update statefulset %s error: %s \n", *stateName, err.Error())
		}

	default:
		fmt.Println(kingpin.MustParse(app.Parse(os.Args[1:])))

		fmt.Println(deploy.FullCommand())

		fmt.Println(listDeploy.FullCommand())

	}

}

// getClient Initializes a clientset
func getClient(k8sconfig string) (*kubernetes.Clientset, error) {

	config, err := clientcmd.BuildConfigFromFlags("", k8sconfig)
	if err != nil {
		return nil, err
	}

	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		return nil, err
	}
	return clientset, nil
}

// rollingDeploy update the image of the deployment
func rollingDeploy(clientset *kubernetes.Clientset, namespace, name, image string) error {

	fmt.Printf("rolling upgrade : %s \n", name)

	updateClient := clientset.AppsV1().Deployments(namespace)

	retryErr := retry.RetryOnConflict(retry.DefaultRetry, func() error {
		// Retrieve the latest version of Deployment before attempting update
		// RetryOnConflict uses exponential backoff to avoid exhausting the apiserver
		result, getErr := updateClient.Get(name, metav1.GetOptions{})
		if getErr != nil {
			panic(fmt.Errorf("Failed to get latest version of Deployment: %v", getErr))
		}

		result.Spec.Template.Spec.Containers[0].Image = image // change nginx version

		_, updateErr := updateClient.Update(result)

		return updateErr
	})

	if retryErr != nil {
		return retryErr
	}

	return nil
}

// rollingStateful update the image of the statefulset
func rollingStateful(clientset *kubernetes.Clientset, namespace, name, image string) error {

	fmt.Printf("rolling upgrade : %s \n", name)

	updateClient := clientset.AppsV1().StatefulSets(namespace)

	retryErr := retry.RetryOnConflict(retry.DefaultRetry, func() error {
		// Retrieve the latest version of Deployment before attempting update
		// RetryOnConflict uses exponential backoff to avoid exhausting the apiserver
		result, getErr := updateClient.Get(name, metav1.GetOptions{})
		if getErr != nil {
			panic(fmt.Errorf("Failed to get latest version of Deployment: %v", getErr))
		}

		result.Spec.Template.Spec.Containers[0].Image = image // change nginx version

		_, updateErr := updateClient.Update(result)

		return updateErr
	})

	if retryErr != nil {
		return retryErr
	}

	return nil
}
