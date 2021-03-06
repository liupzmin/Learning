// Code generated by protoc-gen-go. DO NOT EDIT.
// source: sku/sku.proto

package sku

import (
	context "context"
	fmt "fmt"
	proto "github.com/golang/protobuf/proto"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	math "math"
)

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the proto package it is being compiled against.
// A compilation error at this line likely means your copy of the
// proto package needs to be updated.
const _ = proto.ProtoPackageIsVersion3 // please upgrade the proto package

//NoReply没有返回值
type NoReply struct {
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *NoReply) Reset()         { *m = NoReply{} }
func (m *NoReply) String() string { return proto.CompactTextString(m) }
func (*NoReply) ProtoMessage()    {}
func (*NoReply) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{0}
}

func (m *NoReply) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_NoReply.Unmarshal(m, b)
}
func (m *NoReply) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_NoReply.Marshal(b, m, deterministic)
}
func (m *NoReply) XXX_Merge(src proto.Message) {
	xxx_messageInfo_NoReply.Merge(m, src)
}
func (m *NoReply) XXX_Size() int {
	return xxx_messageInfo_NoReply.Size(m)
}
func (m *NoReply) XXX_DiscardUnknown() {
	xxx_messageInfo_NoReply.DiscardUnknown(m)
}

var xxx_messageInfo_NoReply proto.InternalMessageInfo

type ListSKUReq struct {
	Index                int64    `protobuf:"varint,1,opt,name=Index,proto3" json:"Index,omitempty"`
	PageSize             int64    `protobuf:"varint,2,opt,name=PageSize,proto3" json:"PageSize,omitempty"`
	SKUId                string   `protobuf:"bytes,3,opt,name=SKUId,proto3" json:"SKUId,omitempty"`
	SKUGroup             string   `protobuf:"bytes,4,opt,name=SKUGroup,proto3" json:"SKUGroup,omitempty"`
	SKUName              string   `protobuf:"bytes,5,opt,name=SKUName,proto3" json:"SKUName,omitempty"`
	SKUBrand             string   `protobuf:"bytes,6,opt,name=SKUBrand,proto3" json:"SKUBrand,omitempty"`
	Requisite            int64    `protobuf:"varint,7,opt,name=Requisite,proto3" json:"Requisite,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *ListSKUReq) Reset()         { *m = ListSKUReq{} }
func (m *ListSKUReq) String() string { return proto.CompactTextString(m) }
func (*ListSKUReq) ProtoMessage()    {}
func (*ListSKUReq) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{1}
}

func (m *ListSKUReq) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_ListSKUReq.Unmarshal(m, b)
}
func (m *ListSKUReq) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_ListSKUReq.Marshal(b, m, deterministic)
}
func (m *ListSKUReq) XXX_Merge(src proto.Message) {
	xxx_messageInfo_ListSKUReq.Merge(m, src)
}
func (m *ListSKUReq) XXX_Size() int {
	return xxx_messageInfo_ListSKUReq.Size(m)
}
func (m *ListSKUReq) XXX_DiscardUnknown() {
	xxx_messageInfo_ListSKUReq.DiscardUnknown(m)
}

var xxx_messageInfo_ListSKUReq proto.InternalMessageInfo

func (m *ListSKUReq) GetIndex() int64 {
	if m != nil {
		return m.Index
	}
	return 0
}

func (m *ListSKUReq) GetPageSize() int64 {
	if m != nil {
		return m.PageSize
	}
	return 0
}

func (m *ListSKUReq) GetSKUId() string {
	if m != nil {
		return m.SKUId
	}
	return ""
}

func (m *ListSKUReq) GetSKUGroup() string {
	if m != nil {
		return m.SKUGroup
	}
	return ""
}

func (m *ListSKUReq) GetSKUName() string {
	if m != nil {
		return m.SKUName
	}
	return ""
}

func (m *ListSKUReq) GetSKUBrand() string {
	if m != nil {
		return m.SKUBrand
	}
	return ""
}

func (m *ListSKUReq) GetRequisite() int64 {
	if m != nil {
		return m.Requisite
	}
	return 0
}

type ListSKURes struct {
	Total                int64      `protobuf:"varint,1,opt,name=Total,proto3" json:"Total,omitempty"`
	Rows                 []*SKUInfo `protobuf:"bytes,2,rep,name=Rows,proto3" json:"Rows,omitempty"`
	XXX_NoUnkeyedLiteral struct{}   `json:"-"`
	XXX_unrecognized     []byte     `json:"-"`
	XXX_sizecache        int32      `json:"-"`
}

func (m *ListSKURes) Reset()         { *m = ListSKURes{} }
func (m *ListSKURes) String() string { return proto.CompactTextString(m) }
func (*ListSKURes) ProtoMessage()    {}
func (*ListSKURes) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{2}
}

func (m *ListSKURes) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_ListSKURes.Unmarshal(m, b)
}
func (m *ListSKURes) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_ListSKURes.Marshal(b, m, deterministic)
}
func (m *ListSKURes) XXX_Merge(src proto.Message) {
	xxx_messageInfo_ListSKURes.Merge(m, src)
}
func (m *ListSKURes) XXX_Size() int {
	return xxx_messageInfo_ListSKURes.Size(m)
}
func (m *ListSKURes) XXX_DiscardUnknown() {
	xxx_messageInfo_ListSKURes.DiscardUnknown(m)
}

var xxx_messageInfo_ListSKURes proto.InternalMessageInfo

func (m *ListSKURes) GetTotal() int64 {
	if m != nil {
		return m.Total
	}
	return 0
}

func (m *ListSKURes) GetRows() []*SKUInfo {
	if m != nil {
		return m.Rows
	}
	return nil
}

type SKUInfo struct {
	GID                  string   `protobuf:"bytes,1,opt,name=GID,proto3" json:"GID,omitempty"`
	SKUId                string   `protobuf:"bytes,2,opt,name=SKUId,proto3" json:"SKUId,omitempty"`
	SKUImage             string   `protobuf:"bytes,3,opt,name=SKUImage,proto3" json:"SKUImage,omitempty"`
	SKUGroup             string   `protobuf:"bytes,4,opt,name=SKUGroup,proto3" json:"SKUGroup,omitempty"`
	SKUName              string   `protobuf:"bytes,5,opt,name=SKUName,proto3" json:"SKUName,omitempty"`
	SKUBrand             string   `protobuf:"bytes,6,opt,name=SKUBrand,proto3" json:"SKUBrand,omitempty"`
	SKUBrandSub          string   `protobuf:"bytes,7,opt,name=SKUBrandSub,proto3" json:"SKUBrandSub,omitempty"`
	SKUCategory          string   `protobuf:"bytes,8,opt,name=SKUCategory,proto3" json:"SKUCategory,omitempty"`
	SKUVolume            string   `protobuf:"bytes,9,opt,name=SKUVolume,proto3" json:"SKUVolume,omitempty"`
	IsRequisite          bool     `protobuf:"varint,10,opt,name=IsRequisite,proto3" json:"IsRequisite,omitempty"`
	CreateTime           int64    `protobuf:"varint,11,opt,name=CreateTime,proto3" json:"CreateTime,omitempty"`
	UpdateTime           int64    `protobuf:"varint,12,opt,name=UpdateTime,proto3" json:"UpdateTime,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *SKUInfo) Reset()         { *m = SKUInfo{} }
func (m *SKUInfo) String() string { return proto.CompactTextString(m) }
func (*SKUInfo) ProtoMessage()    {}
func (*SKUInfo) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{3}
}

func (m *SKUInfo) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_SKUInfo.Unmarshal(m, b)
}
func (m *SKUInfo) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_SKUInfo.Marshal(b, m, deterministic)
}
func (m *SKUInfo) XXX_Merge(src proto.Message) {
	xxx_messageInfo_SKUInfo.Merge(m, src)
}
func (m *SKUInfo) XXX_Size() int {
	return xxx_messageInfo_SKUInfo.Size(m)
}
func (m *SKUInfo) XXX_DiscardUnknown() {
	xxx_messageInfo_SKUInfo.DiscardUnknown(m)
}

var xxx_messageInfo_SKUInfo proto.InternalMessageInfo

func (m *SKUInfo) GetGID() string {
	if m != nil {
		return m.GID
	}
	return ""
}

func (m *SKUInfo) GetSKUId() string {
	if m != nil {
		return m.SKUId
	}
	return ""
}

func (m *SKUInfo) GetSKUImage() string {
	if m != nil {
		return m.SKUImage
	}
	return ""
}

func (m *SKUInfo) GetSKUGroup() string {
	if m != nil {
		return m.SKUGroup
	}
	return ""
}

func (m *SKUInfo) GetSKUName() string {
	if m != nil {
		return m.SKUName
	}
	return ""
}

func (m *SKUInfo) GetSKUBrand() string {
	if m != nil {
		return m.SKUBrand
	}
	return ""
}

func (m *SKUInfo) GetSKUBrandSub() string {
	if m != nil {
		return m.SKUBrandSub
	}
	return ""
}

func (m *SKUInfo) GetSKUCategory() string {
	if m != nil {
		return m.SKUCategory
	}
	return ""
}

func (m *SKUInfo) GetSKUVolume() string {
	if m != nil {
		return m.SKUVolume
	}
	return ""
}

func (m *SKUInfo) GetIsRequisite() bool {
	if m != nil {
		return m.IsRequisite
	}
	return false
}

func (m *SKUInfo) GetCreateTime() int64 {
	if m != nil {
		return m.CreateTime
	}
	return 0
}

func (m *SKUInfo) GetUpdateTime() int64 {
	if m != nil {
		return m.UpdateTime
	}
	return 0
}

type SetRequisiteSKUReq struct {
	GID                  string   `protobuf:"bytes,1,opt,name=GID,proto3" json:"GID,omitempty"`
	IsRequisite          bool     `protobuf:"varint,2,opt,name=IsRequisite,proto3" json:"IsRequisite,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *SetRequisiteSKUReq) Reset()         { *m = SetRequisiteSKUReq{} }
func (m *SetRequisiteSKUReq) String() string { return proto.CompactTextString(m) }
func (*SetRequisiteSKUReq) ProtoMessage()    {}
func (*SetRequisiteSKUReq) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{4}
}

func (m *SetRequisiteSKUReq) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_SetRequisiteSKUReq.Unmarshal(m, b)
}
func (m *SetRequisiteSKUReq) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_SetRequisiteSKUReq.Marshal(b, m, deterministic)
}
func (m *SetRequisiteSKUReq) XXX_Merge(src proto.Message) {
	xxx_messageInfo_SetRequisiteSKUReq.Merge(m, src)
}
func (m *SetRequisiteSKUReq) XXX_Size() int {
	return xxx_messageInfo_SetRequisiteSKUReq.Size(m)
}
func (m *SetRequisiteSKUReq) XXX_DiscardUnknown() {
	xxx_messageInfo_SetRequisiteSKUReq.DiscardUnknown(m)
}

var xxx_messageInfo_SetRequisiteSKUReq proto.InternalMessageInfo

func (m *SetRequisiteSKUReq) GetGID() string {
	if m != nil {
		return m.GID
	}
	return ""
}

func (m *SetRequisiteSKUReq) GetIsRequisite() bool {
	if m != nil {
		return m.IsRequisite
	}
	return false
}

type UploadSKUImageReq struct {
	GID                  string   `protobuf:"bytes,1,opt,name=GID,proto3" json:"GID,omitempty"`
	SKUImage             string   `protobuf:"bytes,2,opt,name=SKUImage,proto3" json:"SKUImage,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *UploadSKUImageReq) Reset()         { *m = UploadSKUImageReq{} }
func (m *UploadSKUImageReq) String() string { return proto.CompactTextString(m) }
func (*UploadSKUImageReq) ProtoMessage()    {}
func (*UploadSKUImageReq) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{5}
}

func (m *UploadSKUImageReq) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_UploadSKUImageReq.Unmarshal(m, b)
}
func (m *UploadSKUImageReq) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_UploadSKUImageReq.Marshal(b, m, deterministic)
}
func (m *UploadSKUImageReq) XXX_Merge(src proto.Message) {
	xxx_messageInfo_UploadSKUImageReq.Merge(m, src)
}
func (m *UploadSKUImageReq) XXX_Size() int {
	return xxx_messageInfo_UploadSKUImageReq.Size(m)
}
func (m *UploadSKUImageReq) XXX_DiscardUnknown() {
	xxx_messageInfo_UploadSKUImageReq.DiscardUnknown(m)
}

var xxx_messageInfo_UploadSKUImageReq proto.InternalMessageInfo

func (m *UploadSKUImageReq) GetGID() string {
	if m != nil {
		return m.GID
	}
	return ""
}

func (m *UploadSKUImageReq) GetSKUImage() string {
	if m != nil {
		return m.SKUImage
	}
	return ""
}

type GetSKUByIDReq struct {
	ID                   string   `protobuf:"bytes,1,opt,name=ID,proto3" json:"ID,omitempty"`
	XXX_NoUnkeyedLiteral struct{} `json:"-"`
	XXX_unrecognized     []byte   `json:"-"`
	XXX_sizecache        int32    `json:"-"`
}

func (m *GetSKUByIDReq) Reset()         { *m = GetSKUByIDReq{} }
func (m *GetSKUByIDReq) String() string { return proto.CompactTextString(m) }
func (*GetSKUByIDReq) ProtoMessage()    {}
func (*GetSKUByIDReq) Descriptor() ([]byte, []int) {
	return fileDescriptor_f71b3be6f63ac651, []int{6}
}

func (m *GetSKUByIDReq) XXX_Unmarshal(b []byte) error {
	return xxx_messageInfo_GetSKUByIDReq.Unmarshal(m, b)
}
func (m *GetSKUByIDReq) XXX_Marshal(b []byte, deterministic bool) ([]byte, error) {
	return xxx_messageInfo_GetSKUByIDReq.Marshal(b, m, deterministic)
}
func (m *GetSKUByIDReq) XXX_Merge(src proto.Message) {
	xxx_messageInfo_GetSKUByIDReq.Merge(m, src)
}
func (m *GetSKUByIDReq) XXX_Size() int {
	return xxx_messageInfo_GetSKUByIDReq.Size(m)
}
func (m *GetSKUByIDReq) XXX_DiscardUnknown() {
	xxx_messageInfo_GetSKUByIDReq.DiscardUnknown(m)
}

var xxx_messageInfo_GetSKUByIDReq proto.InternalMessageInfo

func (m *GetSKUByIDReq) GetID() string {
	if m != nil {
		return m.ID
	}
	return ""
}

func init() {
	proto.RegisterType((*NoReply)(nil), "sku.NoReply")
	proto.RegisterType((*ListSKUReq)(nil), "sku.ListSKUReq")
	proto.RegisterType((*ListSKURes)(nil), "sku.ListSKURes")
	proto.RegisterType((*SKUInfo)(nil), "sku.SKUInfo")
	proto.RegisterType((*SetRequisiteSKUReq)(nil), "sku.SetRequisiteSKUReq")
	proto.RegisterType((*UploadSKUImageReq)(nil), "sku.UploadSKUImageReq")
	proto.RegisterType((*GetSKUByIDReq)(nil), "sku.GetSKUByIDReq")
}

func init() { proto.RegisterFile("sku/sku.proto", fileDescriptor_f71b3be6f63ac651) }

var fileDescriptor_f71b3be6f63ac651 = []byte{
	// 472 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xb4, 0x54, 0x4d, 0x6f, 0xd3, 0x40,
	0x14, 0x8c, 0xed, 0xb6, 0x89, 0x5f, 0xfa, 0x01, 0x4f, 0x08, 0x56, 0x11, 0x02, 0x6b, 0x4f, 0xb9,
	0x50, 0x50, 0xb9, 0x20, 0x6e, 0xb4, 0x91, 0x82, 0x65, 0x54, 0xa1, 0xdd, 0x9a, 0xbb, 0x2b, 0x2f,
	0x91, 0x95, 0x8f, 0x75, 0xbd, 0xb6, 0x20, 0xfc, 0x3e, 0x7e, 0x06, 0x37, 0xfe, 0x08, 0xda, 0xf5,
	0x77, 0xcc, 0xb5, 0x37, 0xcf, 0xcc, 0xce, 0xea, 0xcd, 0xf8, 0xd9, 0x70, 0xa6, 0xd6, 0xc5, 0x5b,
	0xb5, 0x2e, 0x2e, 0xd3, 0x4c, 0xe6, 0x12, 0x1d, 0xb5, 0x2e, 0xa8, 0x0b, 0xe3, 0x5b, 0xc9, 0x44,
	0xba, 0xd9, 0xd3, 0xdf, 0x16, 0xc0, 0x97, 0x44, 0xe5, 0x3c, 0x08, 0x99, 0x78, 0xc0, 0x67, 0x70,
	0xec, 0xef, 0x62, 0xf1, 0x93, 0x58, 0x9e, 0x35, 0x77, 0x58, 0x09, 0x70, 0x06, 0x93, 0xaf, 0xd1,
	0x4a, 0xf0, 0xe4, 0x97, 0x20, 0xb6, 0x11, 0x1a, 0xac, 0x1d, 0x3c, 0x08, 0xfd, 0x98, 0x38, 0x9e,
	0x35, 0x77, 0x59, 0x09, 0xb4, 0x83, 0x07, 0xe1, 0x32, 0x93, 0x45, 0x4a, 0x8e, 0x8c, 0xd0, 0x60,
	0x24, 0x30, 0xe6, 0x41, 0x78, 0x1b, 0x6d, 0x05, 0x39, 0x36, 0x52, 0x0d, 0x2b, 0xd7, 0x75, 0x16,
	0xed, 0x62, 0x72, 0xd2, 0xb8, 0x0c, 0xc6, 0x97, 0xe0, 0x32, 0xf1, 0x50, 0x24, 0x2a, 0xc9, 0x05,
	0x19, 0x9b, 0x21, 0x5a, 0x82, 0x2e, 0x3a, 0x29, 0x94, 0x9e, 0xe9, 0x4e, 0xe6, 0xd1, 0xa6, 0x4e,
	0x61, 0x00, 0x7a, 0x70, 0xc4, 0xe4, 0x0f, 0x45, 0x6c, 0xcf, 0x99, 0x4f, 0xaf, 0x4e, 0x2f, 0x75,
	0x29, 0x7a, 0xda, 0xdd, 0x77, 0xc9, 0x8c, 0x42, 0xff, 0xda, 0x66, 0x34, 0xcd, 0xe0, 0x13, 0x70,
	0x96, 0xfe, 0xc2, 0xdc, 0xe0, 0x32, 0xfd, 0xd8, 0x26, 0xb5, 0x87, 0x49, 0xfd, 0x6d, 0xb4, 0x12,
	0x55, 0x05, 0x0d, 0x7e, 0x84, 0x16, 0x3c, 0x98, 0xd6, 0xcf, 0xbc, 0xb8, 0x37, 0x3d, 0xb8, 0xac,
	0x4b, 0x55, 0x27, 0x6e, 0xa2, 0x5c, 0xac, 0x64, 0xb6, 0x27, 0x93, 0xe6, 0x44, 0x4d, 0xe9, 0x26,
	0x79, 0x10, 0x7e, 0x93, 0x9b, 0x62, 0x2b, 0x88, 0x6b, 0xf4, 0x96, 0xd0, 0x7e, 0x5f, 0xb5, 0x4d,
	0x83, 0x67, 0xcd, 0x27, 0xac, 0x4b, 0xe1, 0x2b, 0x80, 0x9b, 0x4c, 0x44, 0xb9, 0xb8, 0x4b, 0xb6,
	0x82, 0x4c, 0x4d, 0xc5, 0x1d, 0x46, 0xeb, 0x61, 0x1a, 0xd7, 0xfa, 0x69, 0xa9, 0xb7, 0x0c, 0xfd,
	0x0c, 0xc8, 0x45, 0xde, 0xdc, 0x57, 0x6d, 0xde, 0xb0, 0xef, 0x83, 0x49, 0xec, 0xc1, 0x24, 0xf4,
	0x13, 0x3c, 0x0d, 0xd3, 0x8d, 0x8c, 0xe2, 0xba, 0xf1, 0xff, 0x5f, 0xd4, 0x7d, 0x45, 0x76, 0xff,
	0x15, 0xd1, 0xd7, 0x70, 0xb6, 0x14, 0x7a, 0x6f, 0xae, 0xf7, 0xfe, 0x42, 0xdb, 0xcf, 0xc1, 0x6e,
	0xdc, 0xb6, 0xbf, 0xb8, 0xfa, 0x63, 0x81, 0xc3, 0x83, 0x10, 0xdf, 0xc0, 0xb8, 0xda, 0x30, 0xbc,
	0x30, 0xab, 0xd3, 0x7e, 0x35, 0xb3, 0x03, 0x42, 0xd1, 0x11, 0x7e, 0x84, 0x8b, 0x83, 0x90, 0xf8,
	0xa2, 0xdc, 0xb8, 0x41, 0xf4, 0x59, 0xb9, 0x8a, 0xf5, 0x17, 0x39, 0xc2, 0x0f, 0x70, 0xde, 0x8f,
	0x85, 0xcf, 0xcd, 0x89, 0x41, 0xd6, 0x81, 0xf3, 0x1d, 0x40, 0x9b, 0x06, 0xd1, 0xa8, 0xbd, 0x78,
	0xb3, 0xde, 0xda, 0xd3, 0xd1, 0xfd, 0x89, 0xf9, 0x2d, 0xbc, 0xff, 0x17, 0x00, 0x00, 0xff, 0xff,
	0x73, 0xdf, 0x92, 0x6f, 0x27, 0x04, 0x00, 0x00,
}

// Reference imports to suppress errors if they are not otherwise used.
var _ context.Context
var _ grpc.ClientConn

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
const _ = grpc.SupportPackageIsVersion4

// SKUClient is the client API for SKU service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
type SKUClient interface {
	ListSKU(ctx context.Context, in *ListSKUReq, opts ...grpc.CallOption) (*ListSKURes, error)
	SetRequisiteSKU(ctx context.Context, in *SetRequisiteSKUReq, opts ...grpc.CallOption) (*NoReply, error)
	UploadSKUImage(ctx context.Context, in *UploadSKUImageReq, opts ...grpc.CallOption) (*NoReply, error)
	GetSKUByID(ctx context.Context, in *GetSKUByIDReq, opts ...grpc.CallOption) (*SKUInfo, error)
}

type sKUClient struct {
	cc *grpc.ClientConn
}

func NewSKUClient(cc *grpc.ClientConn) SKUClient {
	return &sKUClient{cc}
}

func (c *sKUClient) ListSKU(ctx context.Context, in *ListSKUReq, opts ...grpc.CallOption) (*ListSKURes, error) {
	out := new(ListSKURes)
	err := c.cc.Invoke(ctx, "/sku.SKU/ListSKU", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *sKUClient) SetRequisiteSKU(ctx context.Context, in *SetRequisiteSKUReq, opts ...grpc.CallOption) (*NoReply, error) {
	out := new(NoReply)
	err := c.cc.Invoke(ctx, "/sku.SKU/SetRequisiteSKU", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *sKUClient) UploadSKUImage(ctx context.Context, in *UploadSKUImageReq, opts ...grpc.CallOption) (*NoReply, error) {
	out := new(NoReply)
	err := c.cc.Invoke(ctx, "/sku.SKU/UploadSKUImage", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *sKUClient) GetSKUByID(ctx context.Context, in *GetSKUByIDReq, opts ...grpc.CallOption) (*SKUInfo, error) {
	out := new(SKUInfo)
	err := c.cc.Invoke(ctx, "/sku.SKU/GetSKUByID", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// SKUServer is the server API for SKU service.
type SKUServer interface {
	ListSKU(context.Context, *ListSKUReq) (*ListSKURes, error)
	SetRequisiteSKU(context.Context, *SetRequisiteSKUReq) (*NoReply, error)
	UploadSKUImage(context.Context, *UploadSKUImageReq) (*NoReply, error)
	GetSKUByID(context.Context, *GetSKUByIDReq) (*SKUInfo, error)
}

// UnimplementedSKUServer can be embedded to have forward compatible implementations.
type UnimplementedSKUServer struct {
}

func (*UnimplementedSKUServer) ListSKU(ctx context.Context, req *ListSKUReq) (*ListSKURes, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ListSKU not implemented")
}
func (*UnimplementedSKUServer) SetRequisiteSKU(ctx context.Context, req *SetRequisiteSKUReq) (*NoReply, error) {
	return nil, status.Errorf(codes.Unimplemented, "method SetRequisiteSKU not implemented")
}
func (*UnimplementedSKUServer) UploadSKUImage(ctx context.Context, req *UploadSKUImageReq) (*NoReply, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UploadSKUImage not implemented")
}
func (*UnimplementedSKUServer) GetSKUByID(ctx context.Context, req *GetSKUByIDReq) (*SKUInfo, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetSKUByID not implemented")
}

func RegisterSKUServer(s *grpc.Server, srv SKUServer) {
	s.RegisterService(&_SKU_serviceDesc, srv)
}

func _SKU_ListSKU_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(ListSKUReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SKUServer).ListSKU(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/sku.SKU/ListSKU",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SKUServer).ListSKU(ctx, req.(*ListSKUReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _SKU_SetRequisiteSKU_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(SetRequisiteSKUReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SKUServer).SetRequisiteSKU(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/sku.SKU/SetRequisiteSKU",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SKUServer).SetRequisiteSKU(ctx, req.(*SetRequisiteSKUReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _SKU_UploadSKUImage_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(UploadSKUImageReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SKUServer).UploadSKUImage(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/sku.SKU/UploadSKUImage",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SKUServer).UploadSKUImage(ctx, req.(*UploadSKUImageReq))
	}
	return interceptor(ctx, in, info, handler)
}

func _SKU_GetSKUByID_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetSKUByIDReq)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(SKUServer).GetSKUByID(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/sku.SKU/GetSKUByID",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(SKUServer).GetSKUByID(ctx, req.(*GetSKUByIDReq))
	}
	return interceptor(ctx, in, info, handler)
}

var _SKU_serviceDesc = grpc.ServiceDesc{
	ServiceName: "sku.SKU",
	HandlerType: (*SKUServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "ListSKU",
			Handler:    _SKU_ListSKU_Handler,
		},
		{
			MethodName: "SetRequisiteSKU",
			Handler:    _SKU_SetRequisiteSKU_Handler,
		},
		{
			MethodName: "UploadSKUImage",
			Handler:    _SKU_UploadSKUImage_Handler,
		},
		{
			MethodName: "GetSKUByID",
			Handler:    _SKU_GetSKUByID_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "sku/sku.proto",
}
