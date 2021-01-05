递归代码:

```go
func tree(menus []*model.Menu, pid string) []*pb.TreeMenuInfo {
  nodes := make([]*pb.TreeMenuInfo, 0)
	for _, v := range menus {
		if v.ParentID == pid {
			node := new(pb.TreeMenuInfo)
			node.GID = v.GID
			node.Title = v.Title
			node.Name = v.Name
			// ......
			node.Menus = tree(menus, node.GID)
			nodes = append(nodes, node)
		}
	}
	return nodes
}
```

测试用例：

```go
var testCase = []struct {
	origin []*model.Menu
	want   []*pb.TreeMenuInfo
}{
	{
		[]*model.Menu{
			{GID: "0", ParentID: "", Name: "A"},
			{GID: "1", ParentID: "", Name: "B"},
			{GID: "2", ParentID: "", Name: "C"},
			{GID: "3", ParentID: "", Name: "D"},
			{GID: "4", ParentID: "", Name: "E"},
			{GID: "5", ParentID: "", Name: "F"},
		},
		[]*pb.TreeMenuInfo{
			{GID: "0", ParentID: "", Name: "A"},
			{GID: "1", ParentID: "", Name: "B"},
			{GID: "2", ParentID: "", Name: "C"},
			{GID: "3", ParentID: "", Name: "D"},
			{GID: "4", ParentID: "", Name: "E"},
			{GID: "5", ParentID: "", Name: "F"},
		},
	},
	{
		[]*model.Menu{
			{GID: "0", ParentID: "", Name: "A"},
			{GID: "1", ParentID: "0", Name: "B"},
			{GID: "2", ParentID: "", Name: "C"},
			{GID: "3", ParentID: "1", Name: "D"},
			{GID: "4", ParentID: "0", Name: "E"},
			{GID: "5", ParentID: "2", Name: "F"},
			{GID: "6", ParentID: "5", Name: "G"},
			{GID: "7", ParentID: "5", Name: "G"},
			{GID: "8", ParentID: "5", Name: "G"},
			{GID: "9", ParentID: "5", Name: "G"},
		},
		[]*pb.TreeMenuInfo{
			{GID: "0", ParentID: "", Name: "A", Menus: []*pb.TreeMenuInfo{
				{GID: "1", ParentID: "0", Name: "B", Menus: []*pb.TreeMenuInfo{
					{GID: "3", ParentID: "1", Name: "D"},
				}},
				{GID: "4", ParentID: "0", Name: "E"},
			}},
			{GID: "2", ParentID: "", Name: "C", Menus: []*pb.TreeMenuInfo{
				{GID: "5", ParentID: "2", Name: "F", Menus: []*pb.TreeMenuInfo{
					{GID: "6", ParentID: "5", Name: "G"},
					{GID: "7", ParentID: "5", Name: "G"},
					{GID: "8", ParentID: "5", Name: "G"},
					{GID: "9", ParentID: "5", Name: "G"},
				}},
			}},
		},
	},
	{
		[]*model.Menu{
			{GID: "0", ParentID: "", Name: "A"},
			{GID: "1", ParentID: "0", Name: "B"},
			{GID: "2", ParentID: "", Name: "C"},
			{GID: "3", ParentID: "1", Name: "D"},
			{GID: "4", ParentID: "0", Name: "E"},
			{GID: "5", ParentID: "2", Name: "F"},
		},
		[]*pb.TreeMenuInfo{
			{GID: "0", ParentID: "", Name: "A", Menus: []*pb.TreeMenuInfo{
				{GID: "1", ParentID: "0", Name: "B", Menus: []*pb.TreeMenuInfo{
					{GID: "3", ParentID: "1", Name: "D"},
				}},
				{GID: "4", ParentID: "0", Name: "E"},
			}},
			{GID: "2", ParentID: "", Name: "C", Menus: []*pb.TreeMenuInfo{
				{GID: "5", ParentID: "2", Name: "F"},
			}},
		},
	},
}

func TestTree(t *testing.T) {
	for _, w := range testCase {
		tree := tree(w.origin, "")
		jsonTree, _ := json.Marshal(tree)
		t.Logf("tree:%+v\n", string(jsonTree))
		if !reflect.DeepEqual(w.want, tree) {
			t.Errorf("tree error")
		}
	}
}

```

测试失败，是因为`reflect.DeepEqual` 判断 `nil == empty` 为 `false`
解决方法：

```go
func tree(menus []*model.Menu, pid string) []*pb.TreeMenuInfo {
  // 声明一个nil的slice，而不初始化，如果该项无子项则永远为nil
  var nodes []*pb.TreeMenuInfo
	for _, v := range menus {
		if v.ParentID == pid {
			node := new(pb.TreeMenuInfo)
			node.GID = v.GID
			node.Title = v.Title
			node.Name = v.Name
			// ......
			node.Menus = tree(menus, node.GID)
			nodes = append(nodes, node)
		}
	}
	return nodes
}
```
官方解释：[What happens with closures running as goroutines? ](https://golang.org/doc/faq#closures_and_goroutines)