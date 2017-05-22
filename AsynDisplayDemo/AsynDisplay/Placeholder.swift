//
//  Placeholder.swift
//  AsynDisplayDemo
//
//  Created by luhao on 5/21/17.
//  Copyright © 2017 loohawe. All rights reserved.
//

import Foundation
import UIKit

enum UIViewStatus {
    case norman
    case placeholder
}

/**
 一些视图控件的占位形式, 比如转菊花...
 */

extension UILabel {
    
    func setViewStatus(_ status: UIViewStatus) -> Void {
        switch status {
        case .norman:
            self.backgroundColor = UIColor.white
        case .placeholder:
            self.text = nil
            
            self.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
        }
    }
}

extension UIImageView {
    
    func setViewStatus(_ status: UIViewStatus) -> Void {
        switch status {
        case .norman:
            for subview in self.subviews {
                if subview.isKind(of: UIActivityIndicatorView.self) && subview.tag == 1000 {
                    subview.removeFromSuperview()
                }
            }
            self.backgroundColor = UIColor.clear
        case .placeholder:
            self.image = nil
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            loadingIndicator.tag = 1000
            loadingIndicator.startAnimating()
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(loadingIndicator)
            
            loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            self.backgroundColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
        }
    }
}
