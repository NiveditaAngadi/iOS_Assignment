//
//  ActivityIndicatorHandler.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 20/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

protocol ActivityIndicatorHandler {
    var activityIndicator: UIActivityIndicatorView { get }

    func showActivityIndicator()

    func hideActivityIndicator()
}

extension ActivityIndicatorHandler where Self: UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            self.activityIndicator.style = UIActivityIndicatorView.Style.large
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80) //or whatever size you would like
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
