//
//  ArticleModuleFetcher.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

class ArticleModel: AsynFetchModel {
    var title: String!
    var subtitle: String!
    var imageName: String!
}

class ArticleModuleFetcher: AsynFetcher {
    
    override func fetch() {
        
        /**
         模拟网络请求
         */
        DispatchQueue(label: "temp").async {
            
            sleep(6)
            
            /**
             格式化数据, 并通知相应的 module
             */
            DispatchQueue.main.async(execute: {
                let article = ArticleModel()
                article.status = .success
                article.title = "蘑菇租房"
                article.subtitle = "上海租房新政策, 上漂一族一定要看"
                article.imageName = "article"
                
                self.module?.fetchedDataModel(model: article)
            })
        }
        
    }
}
