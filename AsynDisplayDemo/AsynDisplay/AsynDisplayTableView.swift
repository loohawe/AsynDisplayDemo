//
//  AsynDisplayTableView.swift
//  AsynDisplayDemo
//
//  Created by wx on 2017/5/20.
//  Copyright © 2017年 loohawe. All rights reserved.
//

import UIKit

/**
 用于展示的 module, 需要实现此协议, table view 根据此协议进行整合
 */
protocol AsynDisplayModule: NSObjectProtocol {
    
    var view: UIView { get }
    
    func viewWillAddToCell() -> Void
    
}

/**
 Table view 需要实现此协议, 以便接收当前 module 的重绘请求
 */
protocol AsynDisplayUniteHost: NSObjectProtocol {
    func reloadCellWithModule(_ module: AsynDisplayModule) -> Void
}

/**
 用于展示的 module, 需要子类化此类, 需要重绘 subview 时, 调用 func refreshLayout()
 */
class AsynDisplayUnit: NSObject, AsynDisplayModule {
    
    let view = UIView()
    final weak var hostDelegate: AsynDisplayUniteHost?
    
    func viewWillAddToCell() -> Void {
        /**
        let label = UILabel()
        label.text = "You need override method viewDidLoad() -> Void"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.sizeToFit()
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         */
    }
    
    final public func refreshLayout() -> Void {
        if let host = hostDelegate {
            weak var weakself = self
            host.reloadCellWithModule(weakself!)
        }
    }
}

class AsynDisplayTableView: UITableView, UITableViewDelegate, UITableViewDataSource, AsynDisplayUniteHost {
    
    /**
     当各个功能模块初始化之后, 赋值给 moduleList
     moduleList 中的数据会被 add 到 UITableViewCell 用于展示
     */
    public var moduleList: Array<AsynDisplayUnit> = Array<AsynDisplayUnit>() {
        didSet {
            self.reloadData()
        }
    }
    
    // MARK: Lift cycle

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.config()
    }
    
    // MARK: Internal method
    
    private func config() -> Void {
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .singleLine
    }
    
    override func reloadData() {
        for cellIdentifier in Array(Set(moduleList.map({ (element) -> String in
            element.hostDelegate = self
            return "\(type(of: element))"
        }))) {
            self.register(AsynDisplayTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        }
        
        super.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let module = moduleList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(type(of: module))", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        /**
         添加各个业务模块到 UITableViewCell
         添加约束
         */
        cell.contentView.addSubview(module.view)
        let views = ["view": module.view]
        module.view.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addConstraints([
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: [], metrics: nil, views: views)
            ].flatMap({$0}))
        module.viewWillAddToCell()
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        /**
         根据 Cell subview 的约束, 计算合适高度
         */
        let module = moduleList[indexPath.row]
        return module.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height + 1
    }
    
    /**
     展示 module 需要重绘时, 调用到此方法
     */
    public func reloadCellWithModule(_ module: AsynDisplayModule) -> Void {
        let index = moduleList.index { $0 === module }
        if let findIndex = index {
            self.reloadRows(at: [IndexPath(row: findIndex, section: 0)], with: .none)
        }
    }
    
    // MARK: Public method
    
}

class AsynDisplayTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.selectionStyle = .none
    }

}

