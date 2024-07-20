//
//  RequestDelgate.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 19/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}
