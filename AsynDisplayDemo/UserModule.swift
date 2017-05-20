//
//  UserModule.swift
//  AsynDisplayDemo
//
//  Created by wx on 2017/5/20.
//  Copyright © 2017年 loohawe. All rights reserved.
//

import UIKit

class UserModule: NSObject, AsynDisplayModule {
    
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init() {
        super.init()
    }

    // MARK: AsynDisplayModule
    
    func assembly(view: UIView) -> Void {
        
    }
    
    func didLoad(view: UIView) -> Void {
        
    }
}
