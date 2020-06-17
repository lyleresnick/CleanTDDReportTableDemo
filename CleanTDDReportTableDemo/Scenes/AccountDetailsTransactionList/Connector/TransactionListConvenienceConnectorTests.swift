//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListConvenienceConnectorTests: XCTestCase {
    
    private var sut: TransactionListConnector!
    private var controller: TransactionListViewController!
    
    private let fakeNilEntityGateway = FakeNilEntityGateway()
    
    override func setUp() {
        super.setUp()
        
        EntityGatewayFactory.gateway = fakeNilEntityGateway
        
        controller = TransactionListViewController()
        
        sut = TransactionListConnector(viewController: controller, entityGateway: EntityGatewayFactory.gateway)
        sut.configure()
    }
    
    func test_Init_SetsViewController() {
        XCTAssertTrue(sut.viewController === controller)
    }
    
    func test_Init_SetsEntityGateway() {
        XCTAssertTrue(sut.useCase.entityGateway as AnyObject === fakeNilEntityGateway)
    }
    
    func test_Configure_SetsControllersPresenter() {
        XCTAssertNotNil(controller.presenter)
    }
    
    func test_Configure_SetsUseCasesOutput() {
        XCTAssertNotNil(sut.useCase.output)
    }
    
    func test_Configure_SetsPresentersOutput() {
        XCTAssertNotNil(sut.presenter.output)
    }
}
