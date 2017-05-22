//
//  AlbumModule.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

class AlbumModule: AsynDisplayUnit, AsynFetcherBinded {
    
    var albumView: UIView?
    
    override init() {
        super.init()
        
        /**
         视图布局
         */
        albumView = UINib(nibName: "AlbumModule", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        albumView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(albumView!)
        
        let views = ["album": albumView!]
        view.addConstraints([NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[album]-0-|", options: [], metrics: nil, views: views),
                             NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[album]-0-|", options: [], metrics: nil, views: views),
                             ].flatMap({$0}))
        
        for subView in albumView!.subviews {
            let image = subView as! UIImageView
            image.setViewStatus(.placeholder)
        }
    }
    
    /**网络请求成功后, 刷新界面*/
    func fetchedDataModel(model: AsynFetchModel?) -> Void {
        if let album = model as? AlbumModel {
            if album.status == .success {
                if let image1 = albumView!.viewWithTag(1000) as? UIImageView {
                    image1.setViewStatus(.norman)
                    image1.image = UIImage(named: album.firstImage!)
                    image1.sizeToFit()
                }
                if let image2 = albumView!.viewWithTag(1001) as? UIImageView {
                    image2.setViewStatus(.norman)
                    image2.image = UIImage(named: album.secondImage!)
                    image2.sizeToFit()
                }
            }
        }
        
        self.refreshLayout()
    }
}
