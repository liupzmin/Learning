// Command podctl
package main

import (
	"fmt"
	"gopkg.in/alecthomas/kingpin.v2"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
	"os"
	"path/filepath"
	"time"
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

	// Set the command line Flag
	var (
		app        = kingpin.New("pod", "A command-line delete pods in k8s.")
		kubeconfig = app.Flag("kubeconfig", "(optional) absolute path to the kubeconfig file").Short('f').Default(filepath.Join(home, ".kube", "config")).String()
		namespace  = app.Flag("namespace", "(optional) the k8s namespace.").Short('n').Default("default").String()

		list   = app.Command("list", "List all pods in the namespace.")
		delete = app.Command("delete", "Delete all pods in the namesapce.")
	)

	cmd := kingpin.MustParse(app.Parse(os.Args[1:]))

	clientset, err := getClient(*kubeconfig)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Get client error:  %s.\n", err.Error())
	}

	switch cmd {
	// list pods
	case list.FullCommand():

		pods, err := clientset.CoreV1().Pods(*namespace).List(metav1.ListOptions{})
		if err != nil {
			fmt.Fprintf(os.Stderr, "List pods error:  %s.\n", err.Error())
		}

		fmt.Printf("%-60s%-10s%-10s\n", "Name", "Status", "StartTime")
		for _, pod := range pods.Items {

			fmt.Printf("%-60s%-10s%-10s\n", pod.Name, pod.Status.Phase, time.Now().Sub(pod.Status.StartTime.Time))

		}

	// delete pods
	case delete.FullCommand():

		fmt.Printf("delete pods in namesapce: %s \n", *namespace)
		err = clientset.CoreV1().Pods(*namespace).DeleteCollection(&metav1.DeleteOptions{}, metav1.ListOptions{})
		if err != nil {
			fmt.Fprintf(os.Stderr, "Delete pods error:  %s.\n", err.Error())
		}
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
