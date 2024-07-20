//
//  Copyright © 2022 Target. All rights reserved.
//

import XCTest

@testable import ProductViewer

class ProductViewerTests: XCTestCase {
    var subject: ListSection!
    
    override func setUpWithError() throws {
        subject = ListSection(
            index: 0,
            items: []
        )
    }

    override func tearDownWithError() throws {}

    func testListSection() throws {
      //  XCTAssert(!subject.items.isEmpty)
    }

}
