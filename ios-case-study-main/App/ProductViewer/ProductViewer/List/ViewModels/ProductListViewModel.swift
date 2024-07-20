//
//  ProductViewModel.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 19/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

class ProductListViewModel {
    weak var delegate: RequestDelegate?
    
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    var products: [Product] = []

    var numberOfProducts: Int {
        products.count
    }
    
    init() {
        self.state = .idle
    }

    func fetchProducts() {
        self.state = .loading

        let dealsResource = Resource<Products>(url: Target.getDeals.url)
    
        Task {
            do {
                let result = try await WebService().load(resource: dealsResource)
            state = .success
                products = result.products
            } catch {
                products = []
                state = .error(error)
            }
        }
    }
    
    func getProduct(for indexPath: IndexPath) -> Product {
        return products[indexPath.row]
    }
    
    func getProductViewModel(for indexPath: IndexPath) -> ProductViewModel {
        return ProductViewModel(product: products[indexPath.row])
    }
}

class ProductViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: Int {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    var aisle: String {
        guard let aisle = product.aisle else {
            return ""
        }
       return "in aisle " + aisle
    }
    
    var description: String? {
        product.description
    }
    
    var imageUrl: String? {
        product.imageUrl
    }
    
    var regularPrice: String? {
        guard let displayString = product.regularPrice?.displayString else {
            return nil
        }
        return "reg." + displayString
    }
    
    var salePrice: String? {
        guard let displayString = product.salePrice?.displayString else {
            return nil
        }
        return displayString

    }
    
    var fulfillment: String? {
        product.fulfillment
    }
    
    var availability: String? {
        product.availability
    }
}
