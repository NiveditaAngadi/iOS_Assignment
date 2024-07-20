//
//  NetworkConnectionManager.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 20/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import Reachability

class NetworkConnectionManager {
    func hasNetworkConnectivity() -> Bool {
          do {
              let reachability: Reachability = try Reachability()
              let networkStatus = reachability.connection
              
              switch networkStatus {
              case .unavailable:
                  return false
              case .wifi, .cellular:
                  return true
              }
          }
          catch {
              return false
          }
      }
}
