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
        let user = UserModule()
        
        let userVM = UserModuleFetcher(bindModule: user, requestTime:8, requestSuccess: true, image: "avatar_2")
        requestList.append(userVM)
        
        // Album module
        
        let album = AlbumModule()
        
        let albumVM = AlbumModuleFetcher(bindModule: album)
        requestList.append(albumVM)
        
        // Article module
        
        let article = ArticleModule()
        
        let articleVM = ArticleModuleFetcher(bindModule: article)
        requestList.append(articleVM)
        
        // User success
        let userSuccess = UserModule()
        
        let userSuccessVM = UserModuleFetcher(bindModule: userSuccess, requestTime:2, requestSuccess: true, image: "avatar_1")
        requestList.append(userSuccessVM)
        
        // User failed
        let userFailed = UserModule()
        
        let userFailVM = UserModuleFetcher(bindModule: userFailed, requestTime:3, requestSuccess: false, image: "avatar_3")
        requestList.append(userFailVM)
        
        // Config view
        tableView.moduleList = [user, album, article, userSuccess, userFailed]
        
        // Fetch View Data
        for fetcher in requestList {
            fetcher.fetch()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

