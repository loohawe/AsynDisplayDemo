//
//  AsynDisplayTableView.swift
//  AsynDisplayDemo
//
//  Created by wx on 2017/5/20.
//  Copyright © 2017年 loohawe. All rights reserved.
//

import UIKit

protocol AsynDisplayModule {
    
    func assembly(view: UIView) -> Void
    
    func didLoad(view: UIView) -> Void
    
}

class AsynDisplayTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    public var moduleList: Array<AsynDisplayModule> = Array() {
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
    }
    
    override func reloadData() {
        for cellIdentifier in Array(moduleList.map({"\(type(of: $0))"})) {
            self.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        }
        
        super.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let module = moduleList[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "\(type(of: module))")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "\(type(of: moduleList[indexPath.row]))")
            module.assembly(view: cell!.contentView)
        }
        
        module.didLoad(view: cell!.contentView)
        
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    // MARK: Public method
    
}

