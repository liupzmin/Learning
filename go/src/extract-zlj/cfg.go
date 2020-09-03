package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"os"

	"github.com/glory-cd/utils/afis"
	"github.com/glory-cd/utils/log"
	_ "github.com/go-sql-driver/mysql"
	"github.com/pkg/errors"
	"gopkg.in/yaml.v2"
)

type MysqlConfig struct {
	User     string `yaml:"user"`
	Password string `yaml:"password"`
	Host     string `yaml:"host"`
	Port     string `yaml:"port"`
	DB       string `yaml:"db"`
}

type LogConfig struct {
	LogLevel   string `yaml:"loglevel"`   // log level
	Filename   string `yaml:"filename"`   // log file path
	MaxSize    int    `yaml:"maxsize"`    // max size：M
	MaxBackups int    `yaml:"maxbackups"` // How many backups of log files can be saved at most
	MaxAge     int    `yaml:"maxage"`     // How many days should the file be kept
	Compress   bool   `yaml:"compress"`   // Whether to enable compression
}

type GlobalConfig struct {
	Mysql        MysqlConfig `yaml:"mysql"`
	Log          LogConfig   `yaml:"log"`
	PositionFile string      `yaml:"positionFile"`
	Brokers      string      `yaml:"brokers"`
	BatchSize    int         `yaml:"batchsize"`
}

var (
	config     GlobalConfig
	checkPoint position
)

func initConfig() error {

	yamlFile, err := ioutil.ReadFile("conf.yaml")
	if err != nil {
		return errors.WithStack(err)
	}

	err = yaml.Unmarshal(yamlFile, &config)

	if err != nil {
		return errors.WithStack(err)
	}

	log.InitLog(config.Log.Filename, config.Log.MaxSize, config.Log.MaxBackups, config.Log.MaxAge, config.Log.Compress)
	log.SetLevel(config.Log.LogLevel)
	log.Slogger.Info("初始化配置文件成功！")
	return nil
}

func connectDB() (*sql.DB, error) {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", config.Mysql.User, config.Mysql.Password, config.Mysql.Host, config.Mysql.Port, config.Mysql.DB)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	log.Slogger.Info("数据库初始化连接成功！")
	return db, nil
}

func initPosition() error {

	if !afis.IsExists(config.PositionFile) {
		log.Slogger.Info("position文件不存在，即将创建！")
		file, err := os.Create(config.PositionFile)
		if err != nil {
			return errors.WithStack(err)
		}
		err = file.Close()
		if err != nil {
			return errors.WithStack(err)
		}
		log.Slogger.Info("position文件创建成功！")
	}

	filePtr, err := os.Open(config.PositionFile)
	if err != nil {
		return errors.WithStack(err)
	}
	defer filePtr.Close()

	decoder := json.NewDecoder(filePtr)

	err = decoder.Decode(&checkPoint)

	if err != nil && err != io.EOF {
		log.Slogger.Errorf("decode position file error: %s", err.Error())
		return errors.WithStack(err)
	}

	log.Slogger.Info("position文件读取完毕！")

	return nil
}
