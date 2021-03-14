// Command pim
package main

import (
	"fmt"
	"log"
	"os"

	"github.com/spf13/viper"
	"gopkg.in/alecthomas/kingpin.v2"
)

var (
	user          string
	passwd        string
	userAddress   string
	wechatAddress string
	token         string
)

func main() {

	// Set the command line Flag
	var (
		app    = kingpin.New("pim", "A command-line for manipulating permission identities.")
		system = app.Flag("system", "(optional) the system number.").Short('s').Default("1").String()

		get     = app.Command("list", "List all identities for certain system.")
		count   = get.Flag("count", "the identity count that need to list.").Short('n').Default("32").String()
		verbose = get.Flag("verbose", "display identities's details.").Short('v').Bool()

		add          = app.Command("add", "add an identity for certain system.")
		name         = add.Flag("name", "the gid of identity.").Required().String()
		permissions1 = add.Arg("permissions", "all the permissions for identity, e.g. /api/v1/user:GET,/api/v1/user:POST").Required().String()

		edit         = app.Command("edit", "edit an identity for certain system.")
		gid          = edit.Flag("gid", "the gid of identity.").Short('g').Required().String()
		ename        = edit.Flag("name", "the gid of identity.").Required().String()
		permissions2 = edit.Arg("permissions", "all the permissions for identity, e.g. /api/v1/user:GET,/api/v1/user:POST").Required().String()

		delete = app.Command("delete", "Delete an identity of the system.")
		dgid   = delete.Flag("gid", "the gid of identity.").Short('g').Required().String()

		grant = app.Command("grant", "edit an identity for certain system.")
		role  = grant.Flag("role", "the role to be granted.").Short('r').Required().String()
		iden  = grant.Arg("identity", "The identity contains the permissions.").Required().String()
	)
	app.Version("Version: 0.1")
	cmd := kingpin.MustParse(app.Parse(os.Args[1:]))

	if err := login(); err != nil {
		log.Fatal(err.Error())
	}

	switch cmd {
	case add.FullCommand():
		if err := create(*system, *name, *permissions1); err != nil {
			log.Fatal(err.Error())
		}
	case get.FullCommand():
		var err error
		if *verbose {
			err = listDetail(*system, *name, *count)
		} else {
			err = list(*system)
		}

		if err != nil {
			log.Fatal(err.Error())
		}
	case delete.FullCommand():
		if err := remove(*dgid, *system); err != nil {
			log.Fatal(err.Error())
		}
	case edit.FullCommand():
		if err := update(*gid, *system, *ename, *permissions2); err != nil {
			log.Fatal(err.Error())
		}
	case grant.FullCommand():
		if err := accredit(*role, *iden, *system); err != nil {
			log.Fatal(err.Error())
		}
	}
}

func init() {
	viper.SetConfigName("config")     // name of config file (without extension)
	viper.SetConfigType("toml")       // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath("/etc/pim")   // path to look for the config file in
	viper.AddConfigPath("$HOME/.pim") // call multiple times to add many search paths
	viper.AddConfigPath(".")          // optionally look for config in the working directory
	err := viper.ReadInConfig()       // Find and read the config file
	if err != nil {                   // Handle errors reading the config file
		panic(fmt.Errorf("Fatal error config file: %s", err))
	}

	user = viper.GetString("api.username")
	passwd = viper.GetString("api.password")
	userAddress = viper.GetString("api.userAddress")
	wechatAddress = viper.GetString("api.wechatAddress")
}
