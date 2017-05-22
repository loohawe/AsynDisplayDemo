//
//  UserModule.swift
//  AsynDisplayDemo
//
//  Created by wx on 2017/5/20.
//  Copyright © 2017年 loohawe. All rights reserved.
//

import UIKit

/**
 View structure
 +----------------------------------+
 |  +--------+   +--------------+   |
 |  |        |   |    label     |   |
 |  | avatar |   +--------------+   |
 |  |        |                      |
 |  +--------+                      |
 +----------------------------------+
 */

class UserModule: AsynDisplayUnit, AsynFetcherBinded {

    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    
    var dataFetched = false
    
    override init() {
        super.init()
        /**
         视图布局, 为了说明问题, 少引入第三方包, 用了手写 contraint, 写到吐...
         SnapKit 大法好.
         */
        view.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 8.0
        avatarImageView.clipsToBounds = true
        avatarImageView.setViewStatus(.placeholder)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let avatarWidth = NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        let avatarHeight = NSLayoutConstraint(item: avatarImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80)
        avatarImageView.addConstraints([avatarWidth, avatarHeight])
        
        let top = NSLayoutConstraint(item: avatarImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 8.0)
        let left = NSLayoutConstraint(item: avatarImageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 8.0)
        let bottom = NSLayoutConstraint(item: avatarImageView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -8.0)
        view.addConstraints([top, left, bottom])
        
        view.addSubview(nameLabel)
        nameLabel.textColor = UIColor.gray
        nameLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightLight)
        nameLabel.numberOfLines = 0
        nameLabel.preferredMaxLayoutWidth = 271
        nameLabel.setViewStatus(.placeholder)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["nameLabel": nameLabel, "view": view, "avatarImageView": avatarImageView]
        view.addConstraints([NSLayoutConstraint.constraints(withVisualFormat: "H:[avatarImageView]-[nameLabel]-|", options: [], metrics: nil, views: views),
                             NSLayoutConstraint.constraints(withVisualFormat: "V:|-[nameLabel]-(>=8)-|", options: [], metrics: nil, views: views),
                             ].flatMap({$0}))
        
        let labelViews = ["nameLabel": nameLabel]
        nameLabel.addConstraints([NSLayoutConstraint.constraints(withVisualFormat: "H:[nameLabel(<=271)]", options: [], metrics: nil, views: labelViews),
                                  NSLayoutConstraint.constraints(withVisualFormat: "V:[nameLabel(>=30)]", options: [], metrics: nil, views: labelViews),
                                  ].flatMap({$0}))
    }
    
    /**
     网络请求到达, 准备重新绘制界面
     */
    func fetchedDataModel(model: AsynFetchModel?) -> Void {
        if let userModel = model as? UserModel {
            
            self.avatarImageView.setViewStatus(.norman)
            self.nameLabel.setViewStatus(.norman)
            
            if userModel.status == .success {
                self.avatarImageView.image = UIImage(named: userModel.avatarImageName!)
                self.nameLabel.text = userModel.name!
            } else if userModel.status == .fail {
                self.avatarImageView.image = UIImage(named: userModel.avatarImageName!)
                self.nameLabel.text = userModel.name!
            }
            
            self.refreshLayout()
        }
    }
}
