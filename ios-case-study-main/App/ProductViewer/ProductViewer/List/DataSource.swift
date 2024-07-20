//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

struct ListSection: Hashable, Equatable {
    let index: Int
    let items: [ListItem]
}

/// View state for each list item.
struct ListItem: Hashable, Equatable {
    let title: String
    let price: String
    let image: UIImage?
    let index: Int
}
