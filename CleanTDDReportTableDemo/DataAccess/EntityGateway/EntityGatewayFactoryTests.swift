//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class EntityGatewayFactoryTests: XCTestCase {
    
    var sut: EntityGateway!
    var nilGateway: EntityGateway = FakeNilEntityGateway()
    
    override func setUp() {
        super.setUp()
        
        EntityGatewayFactory.gateway = nilGateway
        sut = EntityGatewayFactory.gateway
    }
    
    func test_Make_ReturnsEntityGatewayImpl() {
        XCTAssert(sut as AnyObject === nilGateway as AnyObject)
    }
}
