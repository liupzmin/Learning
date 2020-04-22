package main

import (
	"bytes"
	"log"
	"regexp"
	"strings"

	"github.com/Shopify/sarama"
)

func dispatcherMessage(message []byte) error {
	matched, err := regexp.Match("35=2", message)

	if err != nil {
		return nil
	}

	if matched {
		loginInfoChan <- message
		return nil
	}

	verifyInfoChan <- message
	return nil
}

func handleLogin() {

	producer, err := sarama.NewSyncProducer(strings.Split(brokers, ","), nil)
	if err != nil {
		log.Fatalln(err)
	}
	defer func() {
		if err := producer.Close(); err != nil {
			log.Fatalln(err)
		}
	}()

	for {
		message, ok := <-loginInfoChan
		if !ok {
			return
		}

		matched, _ := regexp.Match("receive message from", message)
		if matched {
			re := filterLoginRecieveData(message)
			sendData(producer, "login-receive", re)
			continue
		}

		re := filterLoginResponseData(message)
		sendData(producer, "login-response", re)
	}
}

func handleVerify() {

	producer, err := sarama.NewSyncProducer(strings.Split(brokers, ","), nil)
	if err != nil {
		log.Fatalln(err)
	}
	defer func() {
		if err := producer.Close(); err != nil {
			log.Fatalln(err)
		}
	}()

	for {
		message, ok := <-verifyInfoChan
		if !ok {
			return
		}
		matched, _ := regexp.Match("receive message from", message)
		if matched {
			re := filterVerifyRecieveData(message)
			sendData(producer, "verify-receive", re)
			continue
		}

		re := filterVerifyResponseData(message)
		sendData(producer, "verify-response", re)

	}
}

func splitKeyValue(message []byte, regex string) []byte {
	var buf bytes.Buffer
	re := regexp.MustCompile(regex)
	r := re.Find(message)

	//fmt.Printf("split string: %s\n", r)

	if r != nil {
		buf.Write(bytes.TrimSpace(bytes.Split(r, []byte("="))[1]))
		//fmt.Printf("split: %+v \n", bytes.Split(r, []byte("=")))
	}

	buf.WriteByte('|')

	return buf.Bytes()
}

func findValue(message []byte, regex string) []byte {
	var buf bytes.Buffer
	re := regexp.MustCompile(regex)
	r := re.Find(message)

	if r != nil {
		buf.Write(r)
	}

	buf.WriteByte('|')

	return buf.Bytes()
}

func filterLoginRecieveData(message []byte) []byte {
	var buf bytes.Buffer

	buf.Write(splitKeyValue(message, `\b34=\d+\b`))
	buf.Write(splitKeyValue(message, `\b35=\d+\b`))
	buf.Write(splitKeyValue(message, `\b1=\w+\b`))
	buf.Write(splitKeyValue(message, `\b2=\w+\b`))
	buf.Write(splitKeyValue(message, `\b5=.*?\|\|`))
	buf.Write(splitKeyValue(message, `\b6=\w+\b`))
	buf.Write(splitKeyValue(message, `\b8=(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b`))
	buf.Write(bytes.Replace(findValue(message, `\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b:`), []byte(":"), []byte(""), 1))
	buf.Write(findValue(message, `[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}`))

	return bytes.TrimSuffix(buf.Bytes(), []byte("|"))
}

func filterLoginResponseData(message []byte) []byte {
	var buf bytes.Buffer

	buf.Write(splitKeyValue(message, `\b34=\d+\b`))
	buf.Write(splitKeyValue(message, `\b35=\d+\b`))
	buf.Write(splitKeyValue(message, `\b49=\w+\b`))
	buf.Write(splitKeyValue(message, `\b51=\w+\b`))
	buf.Write(splitKeyValue(message, `\b122=\d+\b`))
	buf.Write(splitKeyValue(message, `\b52=\d+\b`))
	buf.Write(splitKeyValue(message, `\b749=\d+\b`))
	buf.Write(splitKeyValue(message, `\b2=\w+\b`))
	buf.Write(splitKeyValue(message, `\b3=(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b`))
	buf.Write(splitKeyValue(message, `\b4=\d+\b`))
	buf.Write(splitKeyValue(message, `\b5=\d+\b`))
	buf.Write(splitKeyValue(message, `\b6=\d+\b`))
	buf.Write(bytes.Replace(findValue(message, `\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b:`), []byte(":"), []byte(""), 1))
	buf.Write(findValue(message, `[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}`))

	return bytes.TrimSuffix(buf.Bytes(), []byte("|"))
}

func filterVerifyRecieveData(message []byte) []byte {
	var buf bytes.Buffer

	buf.Write(splitKeyValue(message, `\b34=\d+\b`))
	buf.Write(splitKeyValue(message, `\b35=\d+\b`))
	buf.Write(splitKeyValue(message, `\b2=\w+\b`))
	buf.Write(splitKeyValue(message, `\b4=(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b`))
	buf.Write(splitKeyValue(message, `\b5=\d+\b`))
	buf.Write(splitKeyValue(message, `\b6=(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b`))
	buf.Write(bytes.Replace(findValue(message, `\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b:`), []byte(":"), []byte(""), 1))
	buf.Write(findValue(message, `[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}`))

	return bytes.TrimSuffix(buf.Bytes(), []byte("|"))
}

func filterVerifyResponseData(message []byte) []byte {
	var buf bytes.Buffer

	buf.Write(splitKeyValue(message, `\b34=\d+\b`))
	buf.Write(splitKeyValue(message, `\b35=\d+\b`))
	buf.Write(splitKeyValue(message, `\b51=\w+\b`))
	buf.Write(splitKeyValue(message, `\b122=\d+\b`))
	buf.Write(splitKeyValue(message, `\b52=\d+\b`))
	buf.Write(splitKeyValue(message, `\b749=\d+\b`))
	buf.Write(splitKeyValue(message, `\b1=\d+\b`))
	buf.Write(splitKeyValue(message, `\b2=\w+\b`))
	buf.Write(splitKeyValue(message, `\b3=\w+\b`))
	buf.Write(splitKeyValue(message, `\b5=\d+\b`))
	buf.Write(bytes.Replace(findValue(message, `\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b:`), []byte(":"), []byte(""), 1))
	buf.Write(findValue(message, `[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}`))

	return bytes.TrimSuffix(buf.Bytes(), []byte("|"))
}

func sendData(producer sarama.SyncProducer, topic string, message []byte) {
	msg := &sarama.ProducerMessage{Topic: topic, Value: sarama.StringEncoder(message)}
	_, _, err := producer.SendMessage(msg)
	if err != nil {
		log.Printf("FAILED to send message: %s, msg: %s\n", err, message)
	}
}
