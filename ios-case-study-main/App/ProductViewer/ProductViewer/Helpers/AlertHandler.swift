//
//  AlertHandler.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 20/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showDialog(title: String? = nil,
                           message: String? = nil,
                           actions: [UIAlertAction]? = nil,
                           animated: Bool = true) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let actions = actions {
            actions.forEach { alertAction in
                alertController.addAction(alertAction)
            }
        }

        present(alertController, animated: animated, completion: nil)
    }
    
    public func showOKDialog(title: String? = nil,
                             message: String? = nil,
                             animated: Bool = true,
                             completion: (() -> Void)? = nil) {
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: { _ in completion?() })

        showDialog(title: title, message: message, actions: [okButton])
    }}

