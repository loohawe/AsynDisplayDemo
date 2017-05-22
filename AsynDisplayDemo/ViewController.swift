//
//  ViewController.swift
//  AsynDisplayDemo
//
//  Created by wx on 2017/5/20.
//  Copyright © 2017年 loohawe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: AsynDisplayTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var requestList = [AsynFetcher]()
        
        // User module
        // 用户模块初始化
        let user = UserModule()
        // 用户信息获取
        let userVM = UserModuleFetcher(bindModule: user, requestTime:6, requestSuccess: true, image: "avatar_2")
        requestList.append(userVM)
        
        // Album module
        // 相册模块初始化
        let album = AlbumModule()
        // 相册数据获取
        let albumVM = AlbumModuleFetcher(bindModule: album)
        requestList.append(albumVM)
        
        // Article module
        // 文章模块初始化
        let article = ArticleModule()
        // 文章数据获取
        let articleVM = ArticleModuleFetcher(bindModule: article)
        requestList.append(articleVM)
        
        // User success
        // 其他用户模块, 模拟网络请求成功
        let userSuccess = UserModule()
        // 用户数据获取
        let userSuccessVM = UserModuleFetcher(bindModule: userSuccess, requestTime:2, requestSuccess: true, image: "avatar_1")
        requestList.append(userSuccessVM)
        
        // User failed
        // 模拟网络请求失败
        let userFailed = UserModule()
        
        let userFailVM = UserModuleFetcher(bindModule: userFailed, requestTime:3, requestSuccess: false, image: "avatar_3")
        requestList.append(userFailVM)
        
        
        // Config view
        // 添加到 Table View, 展示各个模块
        tableView.moduleList = [user, album, article, userSuccess, userFailed]
        
        // Fetch View Data
        // 开始网络请求数据
        for fetcher in requestList {
            fetcher.fetch()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

