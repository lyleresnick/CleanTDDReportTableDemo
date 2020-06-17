//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class EntityGatewayImplTests: XCTestCase {
    
    var sut: EntityGateway!
    
    override func setUp() {
        super.setUp()
        
        sut = TestEntityGateway()
    }
    
    func test_Init_SetsDefaultManagers() {
        
        XCTAssertNotNil(sut.transactionManager)
    }
}
