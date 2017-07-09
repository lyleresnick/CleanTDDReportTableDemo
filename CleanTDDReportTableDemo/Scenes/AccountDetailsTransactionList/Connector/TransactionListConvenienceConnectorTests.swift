//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListConvenienceConnectorTests: XCTestCase {
    
    private var sut: TransactionListConnector!
    private var adapter: TransactionListAdapter!
    private var controller: TransactionListViewController!
    
    private let fakeNilEntityGateway = FakeNilEntityGateway()
    
    override func setUp() {
        super.setUp()
        
        EntityGatewayFactory.gateway = fakeNilEntityGateway
        
        controller = TransactionListViewController()
        adapter = TransactionListAdapter()
        
        sut = TransactionListConnector(viewController: controller, adapter: adapter, entityGateway: EntityGatewayFactory.makeEntityGateway())
        sut.configure()
    }
    
    func test_Init_SetsViewController() {
        XCTAssertTrue(sut.viewController === controller)
    }
    
    func test_Init_SetsAdapter() {
        XCTAssertTrue(sut.adapter === adapter)
    }
    
    func test_Init_SetsEntityGateway() {
        XCTAssertTrue(sut.useCase.entityGateway === fakeNilEntityGateway)
    }
    
    func test_Configure_SetsControllersPresenter() {
        XCTAssertNotNil(controller.presenter)
    }
    
    func test_Configure_SetsAdaptersPresenter() {
        XCTAssertNotNil(adapter.presenter)
    }
    
    func test_Configure_SetsUseCasesOutput() {
        XCTAssertNotNil(sut.useCase.output)
    }
    
    func test_Configure_SetsPresentersOutput() {
        XCTAssertNotNil(sut.presenter.output)
    }
}
