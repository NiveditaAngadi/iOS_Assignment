//
//  ViewState.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 19/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
