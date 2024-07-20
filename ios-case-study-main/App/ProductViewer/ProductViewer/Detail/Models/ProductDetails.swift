//
//  ProductDetails.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 18/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

struct ProductDetails: Codable {
    let id: Int
    let title: String
    var aisle: String?
    var description: String?
    var imageUrl: String?
    var regularPrice: Price?
    var salePrice: Price?
    var fulfillment: String?
    var availability: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case description
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case fulfillment
        case availability
    }
}
