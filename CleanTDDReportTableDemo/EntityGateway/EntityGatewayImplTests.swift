//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo


class EntityGatewayImplTests: XCTestCase {
    
    var sut: EntityGateway!
    var sut2: EntityGateway!
    var sut3: EntityGateway!
    var oneSourceManager = OneSourceManager()
    var twoSourceManager = TwoSourceManager()
    
    override func setUp() {
        super.setUp()
        
        sut = EntityGatewayImpl()
        sut2 = EntityGatewayImpl(oneSourceManager: oneSourceManager)
        sut3 = EntityGatewayImpl(twoSourceManager: twoSourceManager)
    }
    
    func test_Init_SetsDefaultManagers() {
        
        XCTAssertNotNil(sut.oneSourceManager)
        XCTAssertNotNil(sut.twoSourceManager)
    }
    
    func test_Init_SetsOneDefaultsTwoManagers() {
        
        XCTAssertNotNil(sut2.oneSourceManager)
        XCTAssertTrue(sut2.oneSourceManager === oneSourceManager)
        XCTAssertNotNil(sut2.twoSourceManager)
    }
    
    func test_Init_SetsTwoDefaultsOneManagers() {
        
        XCTAssertNotNil(sut3.oneSourceManager)
        XCTAssertNotNil(sut3.twoSourceManager)
        XCTAssertTrue(sut3.twoSourceManager === twoSourceManager)
    }
    
    
    
    
}
