//
//  UserModuleFetcher.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

class UserModel: AsynFetchModel {
    var avatarImageName: String?
    var name: String?
}

class UserModuleFetcher: AsynFetcher {
    
    var requestSuccess: Bool
    var requestTime: Int
    var imageName: String
    
    init(bindModule: AsynFetcherBinded, requestTime time: Int, requestSuccess success: Bool, image: String) {
        imageName = image
        requestTime = time
        self.requestSuccess = success
        super.init(bindModule: bindModule)
    }
    
    override func fetch() {

        /**
         模拟网络请求
         */
        DispatchQueue(label: "temp").async {
            sleep(UInt32(self.requestTime))
            
            /**
             格式化数据, 并通知相应的 module
             */
            DispatchQueue.main.async(execute: {
                
                let user = UserModel()
                if self.requestSuccess {
                user.status = .success
                user.avatarImageName = self.imageName
                user.name = "Hassan Rouhani\nRouhani was deputy speaker of the fourth and fifth terms of the Parliament of Iran (Majlis) and Secretary of the Supreme National Security Council from 1989 to 2005.[3] In the latter capacity, he was the country's top negotiator with the EU three, UK, France, and Germany, on nuclear technology in Iran, and has also served as a Shi'ite[13] ijtihadi cleric,[14] and economic trade negotiator.[15][16]:138 He has expressed official support for upholding the rights of ethnic and religious minorities.[17] In 2013, he appointed former industries minister Eshaq Jahangiri as his first vice-president."
                } else {
                    user.status = .fail
                    user.avatarImageName = "network_error"
                    user.name = "加载失败, 请稍后重试"
                }
                self.module?.fetchedDataModel(model: user)
            })
        }
        
    }
}
