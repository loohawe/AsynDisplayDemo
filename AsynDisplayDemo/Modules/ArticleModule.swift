//
//  ArticleModule.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import UIKit

class ArticleModule: AsynDisplayUnit, AsynFetcherBinded {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init() {
        super.init()
        if let articleView = Bundle.main.loadNibNamed("ArticleModule", owner: self, options: nil)?.first as? UIView {
            articleView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(articleView)
            let views = ["article": articleView]
            view.addConstraints([NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[article(>=100)]-0-|", options: [], metrics: nil, views: views),
                                 NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[article(>=96)]-0-|", options: [], metrics: nil, views: views),
                                 ].flatMap({$0}))
            
            self.titleLabel.setViewStatus(.placeholder)
            self.subtitleLabel.setViewStatus(.placeholder)
            self.imageView.setViewStatus(.placeholder)
        }
    }
    
    func fetchedDataModel(model: AsynFetchModel?) -> Void {
        
        self.titleLabel.setViewStatus(.norman)
        self.subtitleLabel.setViewStatus(.norman)
        self.imageView.setViewStatus(.norman)
        
        if let article = model as? ArticleModel {
            if article.status == .success {
                self.titleLabel.text = article.title
                self.subtitleLabel.text = article.subtitle
                self.imageView.image = UIImage(named: article.imageName)
            } else {
                
            }
        }
        
        self.refreshLayout()
    }
}
