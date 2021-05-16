package main

import (
	"context"
	"crypto/md5"
	"encoding/hex"
	"io"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	pb "play/skutool/proto"

	"github.com/go-resty/resty/v2"
	"google.golang.org/grpc"
)

const (
	GroupLink = "32ab8d57-d4f7-421d-8cbb-6eb3cd06c42a"
	URLPrefix = "http://192.168.0.63:8888"
	Path      = "/api/v1/dfs/upload/direct"
	Address   = "192.168.0.63:15005"
)

type Response struct {
	Code int64
	Msg  string
	Data URL
}

type URL struct {
	Abs string
	Rel string
}

func main() {
	ctx := context.Background()

	file := os.Args[1]

	fileName := filepath.Base(file)

	skuID := strings.Split(fileName, ".")[0]
	log.Printf("the sku id: %s\n", skuID)

	conn, err := grpc.Dial(Address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("grpc dial failed: %s\n", err.Error())
	}
	defer conn.Close()

	cli := pb.NewSKUClient(conn)

	info, err := cli.GetSKUByID(ctx, &pb.GetSKUByIDReq{
		ID: skuID,
	})
	if err != nil {
		log.Printf("Get SKU By ID failed: %s\n", err.Error())
		os.Exit(0)
	}

	f, err := os.Open(file)
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	hash, err := getFileHash(f)
	if err != nil {
		log.Fatalf("getFileHash failed: %s\n", err.Error())
	}

	s, err := f.Stat()
	if err != nil {
		log.Fatal(err)
	}
	size := s.Size()

	url := URLPrefix + Path

	result := new(Response)

	client := resty.New()
	resp, err := client.R().
		SetFile("file", file).
		SetFormData(map[string]string{
			"GroupLink": GroupLink,
			"Name":      fileName,
			"Hash":      hash,
			"Size":      strconv.FormatInt(size, 10),
		}).
		SetResult(result).
		Post(url)

	if err != nil {
		log.Fatalf("Direct Upload Failed: %s\n", err.Error())
	}

	log.Printf("result: %#v\n resp: %s\n", result, resp)

	_, err = cli.UploadSKUImage(ctx, &pb.UploadSKUImageReq{
		GID:      info.GID,
		SKUImage: result.Data.Rel,
	})

	if err != nil {
		log.Fatalf("UploadSKUImage failed: %s\n", err.Error())
	}
}

func getFileHash(f io.Reader) (string, error) {
	h := md5.New()
	if _, err := io.Copy(h, f); err != nil {
		return "", err
	}
	return hex.EncodeToString(h.Sum(nil)), nil
}
