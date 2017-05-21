//
//  AlbumModuleFetcher.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

class AlbumModel: AsynFetchModel {
    var firstImage: String?
    var secondImage: String?
}

class AlbumModuleFetcher: AsynFetcher {
    override func fetch() {
        
        DispatchQueue(label: "temp").async {
            sleep(5)
            DispatchQueue.main.async(execute: {
                let album = AlbumModel()
                album.status = .success
                album.firstImage = "pic_1"
                album.secondImage = "pic_2"
                
                self.module?.fetchedDataModel(model: album)
            })
        }
        
    }
}
