//
//  ProductDealsFetchTests.swift
//  ProductViewerTests
//
//  Created by Nivedita Angadi on 20/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductDealsFetchTests: XCTestCase {

    var sut: ProductListViewModel!
    
    override func setUp()  {
        super.setUp()
    }
    
    func setupData() {
        sut = ProductListViewModel()
        
        let products = readProductDealsFromBundle()
        sut.products = products?.products ?? []
    }

    func testFetchProductDeals() async throws {
        
        let dealsResource = Resource<Products>(url: Target.getDeals.url)
        let result = try await WebService().load(resource: dealsResource)
        
        XCTAssertNotNil(result.products)
    }
    
    func testForNumberOfProductDeals() async throws {
        setupData()
        
        let numberOfProducts = sut.numberOfProducts
        
        XCTAssertEqual(numberOfProducts, 20)
    }
    
    func readProductDealsFromBundle() -> Products? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "productDeals_mocks", withExtension: "json") else {
            return nil
        }
        
        return  try? readJSONFile(with: url)
    }

    func readJSONFile<T: Codable>(with url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

}
