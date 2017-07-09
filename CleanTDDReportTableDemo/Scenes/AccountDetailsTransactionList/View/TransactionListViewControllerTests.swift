//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListViewControllerTests: XCTestCase {
    
    private var sut: TransactionListViewController!
    private var stubPresenter: StubTransactionListPresenter!
    private var fakeIBLoader = FakeIBLoader() // held strong due to weak injection target

    override func setUp() {
        super.setUp()

        let useCase = TransactionListUseCase( entityGateway: FakeNilEntityGateway())
        stubPresenter = StubTransactionListPresenter(useCase: useCase )
        sut = fakeIBLoader.load( sut: TransactionListViewController(), presenter: stubPresenter, useCase: useCase )

        _ = sut.view
    }
    
    func test_viewDidLoad_CallsPresenterEventViewReady() {
        
        XCTAssertTrue(stubPresenter.viewReadyCalled)
    }
        
    // MARK: Stubs

    private class FakeIBLoader {

        let tableView = UITableView()
        let adapter = TransactionListAdapter()

        func load(sut: TransactionListViewController, presenter: TransactionListPresenter, useCase: TransactionListUseCase) -> TransactionListViewController {
            
            sut.setValue(adapter, forKey: "adapter")
            sut.setValue(tableView, forKey: "tableView")
            
            TransactionListConnector(viewController: sut, adapter: adapter, useCase: useCase, presenter: presenter).configure()
            return sut
        }
    }

    class StubTransactionListPresenter: TransactionListPresenter {
        
        var viewReadyCalled = false
        
        override func eventViewReady() {
            viewReadyCalled = true
        }
    }

}

