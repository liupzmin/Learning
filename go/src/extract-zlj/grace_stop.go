package main

import (
	"github.com/glory-cd/utils/log"
	"os"
	"os/signal"
	"syscall"
)

// Signal processing function
func gracefulHandle() {
	// Register signal
	signals := make(chan os.Signal)
	signal.Notify(signals, syscall.SIGHUP, syscall.SIGTERM, syscall.SIGINT)
	// Monitoring signal
	for sig := range signals {
		switch sig {
		case syscall.SIGINT, syscall.SIGTERM:
			log.Slogger.Infof("收到信号：%s, 开始退出！", sig)
			close(done)
			err := db.Close()
			if err != nil {
				log.Slogger.Errorf("close db error: %s", err.Error())
			}

			os.Exit(0)
		case syscall.SIGHUP:
			// Upon receipt of SIGHUP, forkexec restarts
			execSpec := &syscall.ProcAttr{
				Env:   os.Environ(),
				Files: []uintptr{os.Stdin.Fd(), os.Stdout.Fd(), os.Stderr.Fd()},
			}
			// Fork exec the new process
			fork, err := syscall.ForkExec(os.Args[0], os.Args, execSpec)
			if err != nil {
				log.Slogger.Fatalf("Fail to fork: %s", err.Error())
			}
			log.Slogger.Infof("SIGHUP received: fork-exec to %d", fork)

			log.Slogger.Infof("Server gracefully shutdown: %d", os.Getpid())

			// Stop the old server, all the connections have been closed and the new one is running
			os.Exit(0)
		}
	}
}
