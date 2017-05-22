<p align="center" >
  <img src="https://raw.github.com/AFNetworking/AFNetworking/assets/afnetworking-logo.png" alt="AFNetworking" title="AFNetworking">
</p>

[![Pod License](http://img.shields.io/cocoapods/l/SDWebImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)

## 集成方式

- 导入类 `AsynDisplayTableView`, `AsynFetcher`, `Placeholder`. 目录名称(AsynDisplayDemo/AsynDisplay)

## 使用

### 业务模块
- 子类化 `AsynDisplayUnit`, 继承到属性 `view`
- 在子类的初始化后, 在 `view` 上添加需要展示的 `subview`, 并对 `subview` 布局, 保证约束完整
- eg.
```
class UserModule: AsynDisplayUnit {
    
    override init() {
        super.init()
        
        view.addSubview(subview)
        ...
        subview.addConstraints(...)
        view.addConstraints(...)
        ...
```

### 业务数据获取
- 子类化 `AsynFetchModel` 数据 model 
- 子类化 `AsynFetcher` 数据获取者, 继承属性 `module`, 复写方法 `func fetch() -> Void`, 在方法内格式化数据 model, 并调用方法 `self.module?.fetchedDataModel(model: user)` 通知视图
- 相应的视图实现 `AsynFetcherBinded` 协议, 接收 `fetcher` 的通知
- eg.
```
class UserModule: AsynFetcherBinded {
	func fetchedDataModel(model: AsynFetchModel?) -> Void {
		...
		self.refreshLayout()
	}
}
```

### 集成到 ViewController
- 创建业务模块实例 `module`
- 创建业务数据获取者实例 `fetcher` 或叫 `ViewModuel`
- 注册到 `AsynDisplayTableView`
- 获取数据
- eg.
```
let user = UserModule() // 业务模块
let userVM = UserModuleFetcher() // 数据获取者
...
AsynDisplayTableView().moduleList = [user, ...] // 注册到 AsynDisplayTableView
userVM.fetch() // 获取数据
...
```

## 设计思路

<p align="center" >
  <img src="https://github.com/loohawe/AsynDisplayDemo/blob/master/design_structure.jpg" alt="AsynDisplayDemo" title="AsynDisplayDemo">
</p>

分为三个功能块
1. 视图展示 `AsynDisplayUnit`

	设计参考 `UIViewController`. `Unit` 持有 `view`, 在 `view` 上定制需要展示的数据, 最终这个 `view` 会被添加到 `UITableViewCell`上. `view` 上的 `subview` 可完全定制, 以应付多遍的需求. 同时实现数据获取的协议, 当数据获取成功后, 能够接收重新绘制视同的通知.

2. 数据获取 `AsynFetcher`
	
	负责格式化数据 `model`, 并通知绑定的视图 `unit`.

3. 展示引擎 `AsynDisplayTableView` 主要由 `UITableView` 实现
	
	内部由 `UITableView` 实现, 当有 `unit` 注册时, 添加 `unit.view` 到 `UITableViewCell`. 保证 `UITableViewCell` 的复用, 已经 `UITableViewCell` 高度的正确获取.

## 优势

- 集成简单, 只需初始化业务 `module`, 并赋值给 `AsynDisplayTableView` 即可, 如果需要获取数据, 绑定相应的 `fetcher` 即可. 遵从 "高内聚, 低耦合" 的架构理念

- 高度定制, 实现业务逻辑时, 编码方式类似熟悉的 `UIViewController`, 在 `view`上添加 `subview` 后, 只要保证约束完整正确, 就可以在 `UITableView` 中正确显示.

> 由于时间有限, 仅在 `iOS 10.x` 系统下做过测试, 未测试在其他 iOS 版本. 
