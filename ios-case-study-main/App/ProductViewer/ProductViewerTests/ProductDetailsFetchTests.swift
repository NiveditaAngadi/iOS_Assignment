//
//  ProductDetailsFetchTests.swift
//  ProductViewerTests
//
//  Created by Nivedita Angadi on 20/07/24.
//  Copyright © 2024 Target. All rights reserved.
//

import XCTest
@testable import ProductViewer

final class ProductDetailsFetchTests: XCTestCase {
    
    func testFetchProductDetails() async throws {
        
        let detailsResource = Resource<ProductDetails>(url: Target.getDealDetails(id: 1).url)
        let result = try await WebService().load(resource: detailsResource)
        
        XCTAssertNotNil(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
