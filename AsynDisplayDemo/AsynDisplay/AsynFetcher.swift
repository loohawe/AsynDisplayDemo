//
//  AsynFetcher.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

enum AsynFetchStatus {
    case sending
    case success
    case fail
}

/**
 module 需要实现的协议, 接受数据获取成功的通知
 */
protocol AsynFetcherBinded: NSObjectProtocol {
    func fetchedDataModel(model: AsynFetchModel?) -> Void
}

/**
 module 用于展示的数据 model, 需要根据不同的 module 子类化
 */
class AsynFetchModel: NSObject {
    var status: AsynFetchStatus = .sending
}

/**
 数据获取者, 通过与展示的 module 绑定通知 module
 每个 module 对应一个数据获取者
 使用时需要子类化
 */
class AsynFetcher: NSObject {
    
    weak var module: AsynFetcherBinded?
    
    /**
     绑定到 module, 当数据获取成功时, 通知其刷新
     */
    init(bindModule: AsynFetcherBinded) {
        super.init()
        module = bindModule
    }
    
    /**
     需要覆盖, 用于获取数据并格式化, 同时通知 module 重新绘制
     */
    public func fetch() -> Void {
        module?.fetchedDataModel(model: nil)
    }
}
