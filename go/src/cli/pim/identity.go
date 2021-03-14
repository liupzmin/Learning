package main

import (
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"

	"github.com/go-resty/resty/v2"
	"github.com/golang-module/carbon"
	"github.com/olekukonko/tablewriter"
)

type account struct {
	LoginID  string
	PassWord string
}

type response struct {
	Code int         `json:"Code"`
	Msg  string      `json:"Msg"`
	Data interface{} `json:"Data,omitempty"`
}

type permissionsInfo struct {
	MenuURL string `json:"MenuURL"`
	Method  string `json:"Method"`
}

type addReq struct {
	Name        string
	SystemID    string
	Permissions []*permissionsInfo
}

type editReq struct {
	GID         string
	Name        string
	SystemID    string
	Permissions []*permissionsInfo
}

type listDetailResponse struct {
	Code int        `json:"Code"`
	Msg  string     `json:"Msg"`
	Data identities `json:"Data,omitempty"`
}

type identities struct {
	Total int64    `json:"Total"`
	Rows  []detail `json:"Rows"`
}

type detail struct {
	GID         string            `json:"GID"`
	Name        string            `json:"Name"`
	SystemID    string            `json:"SystemID"`
	Permissions []permissionsInfo `json:"Permissions"`
	CreateUser  string            `json:"CreateUser"`
	UpdateUser  string            `json:"UpdateUser"`
	CreateTime  int64             `json:"CreateTime"`
	UpdateTime  int64             `json:"UpdateTime"`
}

type listResponse struct {
	Code int    `json:"Code"`
	Msg  string `json:"Msg"`
	Data names  `json:"Data,omitempty"`
}

type names struct {
	Names []string `json:"Names"`
}

type deleteReq struct {
	GID      string `json:"GID"`
	SystemID string `json:"SystemID"`
}

func login() error {
	api := "/api/v1/manage/login"
	url := userAddress + api

	var result response
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(account{LoginID: user, PassWord: passwd}).
		SetResult(&result).
		Post(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}

	token = result.Data.(map[string]interface{})["Token"].(string)
	return nil
}

func list(system string) error {
	var api = "/api/v1/manage/permidentity/all"
	url := userAddress + api

	var result listResponse
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetQueryParams(map[string]string{
			"SystemID": system,
		}).
		SetResult(&result).
		SetAuthToken(token).
		Get(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}

	data := make([][]string, 0)

	for i, v := range result.Data.Names {
		row := []string{strconv.Itoa(i + 1), v}
		data = append(data, row)
	}

	table := tablewriter.NewWriter(os.Stdout)
	table.SetHeader([]string{"ID", "Name"})
	table.SetAutoMergeCells(true)
	table.SetRowLine(true)

	table.SetHeaderColor(tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor})

	table.SetColumnColor(tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiBlackColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiRedColor})

	table.AppendBulk(data)
	table.Render()
	return nil
}

func listDetail(system, name, count string) error {
	var addAPI = "/api/v1/manage/permidentity/listdetail"
	url := userAddress + addAPI

	var result listDetailResponse
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetQueryParams(map[string]string{
			"Index":    "1",
			"PageSize": count,
			"SystemID": system,
			"Name":     name,
		}).
		SetResult(&result).
		SetAuthToken(token).
		Get(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}

	data := make([][]string, 0)

	for _, v := range result.Data.Rows {
		for _, r := range v.Permissions {
			row := []string{
				v.SystemID,
				v.GID,
				v.Name,
				carbon.CreateFromTimestamp(v.CreateTime).ToDateTimeString(),
				carbon.CreateFromTimestamp(v.UpdateTime).ToDateTimeString(),
				r.MenuURL,
				r.Method,
			}
			data = append(data, row)
		}
	}

	table := tablewriter.NewWriter(os.Stdout)
	table.SetHeader([]string{"SystemID", "GID", "Name", "CreateTime", "UpdateTime", "MenuURL", "Method"})
	table.SetAutoMergeCells(true)
	table.SetRowLine(true)

	table.SetHeaderColor(tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.BgMagentaColor})

	table.SetColumnColor(tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiBlueColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiBlueColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiRedColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiBlueColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiBlueColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiCyanColor},
		tablewriter.Colors{tablewriter.Bold, tablewriter.FgHiGreenColor})

	table.AppendBulk(data)
	table.Render()

	return nil
}

func create(system, name, data string) error {
	api := "/api/v1/manage/permidentity"
	url := userAddress + api

	pis := make([]*permissionsInfo, 0)
	apis := strings.Split(data, ",")
	for _, v := range apis {
		pairs := strings.Split(v, ":")
		pi := &permissionsInfo{
			MenuURL: pairs[0],
			Method:  pairs[1],
		}
		pis = append(pis, pi)
	}

	identity := addReq{
		Name:        name,
		SystemID:    system,
		Permissions: pis,
	}

	var result response
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(identity).
		SetResult(&result).
		SetAuthToken(token).
		Put(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}
	return nil
}

func update(gid, system, name, data string) error {
	var api = "/api/v1/manage/permidentity"
	url := userAddress + api

	pis := make([]*permissionsInfo, 0)
	apis := strings.Split(data, ",")
	for _, v := range apis {
		pairs := strings.Split(v, ":")
		pi := &permissionsInfo{
			MenuURL: pairs[0],
			Method:  pairs[1],
		}
		pis = append(pis, pi)
	}

	identity := editReq{
		GID:         gid,
		Name:        name,
		SystemID:    system,
		Permissions: pis,
	}

	var result response
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(identity).
		SetResult(&result).
		SetAuthToken(token).
		Post(url)

	if err != nil {
		return err
	}
	type deleteReq struct {
		GID      string
		SystemID string
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}
	return nil

}

func remove(gid, system string) error {
	var api = "/api/v1/manage/permidentity"
	url := userAddress + api

	identity := deleteReq{
		GID:      gid,
		SystemID: system,
	}

	var result response
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(identity).
		SetResult(&result).
		SetAuthToken(token).
		Delete(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}
	return nil
}

type grantReq struct {
	Role     string
	Identity string
	SystemID string
}

func accredit(role, identity, system string) error {
	var api = "/api/v1/wechat/grant"
	url := wechatAddress + api

	grant := grantReq{
		Role:     role,
		Identity: identity,
		SystemID: system,
	}

	var result response
	client := resty.New()
	resp, err := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(grant).
		SetResult(&result).
		SetAuthToken(token).
		Put(url)

	if err != nil {
		return err
	}

	if resp.StatusCode() != http.StatusOK {
		return fmt.Errorf("HTTP Code：%d, err: %#v; API Code: %d, Msg: %s", resp.StatusCode(), resp.Error(), result.Code, result.Msg)
	}

	if result.Code != 0 {
		return fmt.Errorf("API Code: %d, err: %s", result.Code, result.Msg)
	}
	return nil
}
