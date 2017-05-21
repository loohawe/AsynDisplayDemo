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

protocol AsynFetcherBinded: NSObjectProtocol {
    func fetchedDataModel(model: AsynFetchModel?) -> Void
}

class AsynFetchModel: NSObject {
    var status: AsynFetchStatus = .sending
}

class AsynFetcher: NSObject {
    
    weak var module: AsynFetcherBinded?
    
    init(bindModule: AsynFetcherBinded) {
        super.init()
        module = bindModule
    }
    
    public func fetch() -> Void {
        module?.fetchedDataModel(model: nil)
    }
}
