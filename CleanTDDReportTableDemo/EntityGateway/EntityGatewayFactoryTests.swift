//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class EntityGatewayFactoryTests: XCTestCase {
    var sut: EntityGateway!
    var sut2: EntityGateway!
    var sut3: EntityGateway!
    var oneSourceManager = OneSourceManager()
    var twoSourceManager = TwoSourceManager()
    
    override func setUp() {
        super.setUp()
        
        sut = EntityGatewayFactory.makeEntityGateway()
        sut2 = EntityGatewayFactory.makeEntityGateway(oneSourceManager: oneSourceManager)
        sut3 = EntityGatewayFactory.makeEntityGateway(twoSourceManager: twoSourceManager)
    }
    
    func test_Make_ReturnsEntityGatewayImpl() {
        XCTAssert(sut is EntityGatewayImpl)
    }
    
    func test_Make_ReturnsEntityGatewayWithDefaultManagers() {
        
        XCTAssertNotNil(sut.oneSourceManager)
        XCTAssertNotNil(sut.twoSourceManager)
    }
    
    func test_Make_ReturnsEntityGatewayWithSetOneDefaultTwoManagers() {
        
        XCTAssertNotNil(sut2.oneSourceManager)
        XCTAssertTrue(sut2.oneSourceManager === oneSourceManager)
        XCTAssertNotNil(sut2.twoSourceManager)
    }
    
    func test_Make_ReturnsEntityGatewayWithSetTwoDefaultOneManagers() {
        
        XCTAssertNotNil(sut3.oneSourceManager)
        XCTAssertNotNil(sut3.twoSourceManager)
        XCTAssertTrue(sut3.twoSourceManager === twoSourceManager)
    }
    
    
}
