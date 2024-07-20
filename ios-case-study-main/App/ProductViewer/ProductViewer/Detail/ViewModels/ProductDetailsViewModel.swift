//
//  ProductDetailsViewModel.swift
//  ProductViewer
//
//  Created by Nivedita Angadi on 19/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation

class ProductDetailsViewModel: ProductViewModel {
    weak var delegate: RequestDelegate?
    
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    let selectedProductId: Int
    
    var productDetails: ProductDetails?
    
    override var description: String? {
        productDetails?.description
    }
    
    init(selectedProduct: Product) {
        self.state = .idle
        self.selectedProductId = selectedProduct.id
        super.init(product: selectedProduct)
    }
    
    func fetchProductDetails(for id: Int)  {
        self.state = .loading

        let detailsResource = Resource<ProductDetails>(url: Target.getDealDetails(id: id).url)
        
        Task {
            do {
                let result = try await WebService().load(resource: detailsResource)
                productDetails = result
                state = .success
            } catch {
                productDetails = nil
                state = .error(error)
            }
        }
    }
}
