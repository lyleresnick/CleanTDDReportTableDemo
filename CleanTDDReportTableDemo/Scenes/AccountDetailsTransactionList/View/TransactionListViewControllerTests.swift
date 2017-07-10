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
    
    func test_showReport_CallsTableViewGetRowCount() {
        sut.showReport()
        let dataSource = sut.tableView.dataSource as! StubTransactionListAdapter
        XCTAssertTrue(dataSource.adapterCalled)

        
    }
        
    // MARK: Stubs

    private class FakeIBLoader {

        let tableView = UITableView()
        let adapter = StubTransactionListAdapter()

        func load(sut: TransactionListViewController, presenter: TransactionListPresenter, useCase: TransactionListUseCase) -> TransactionListViewController {
            
            sut.setValue(adapter, forKey: "adapter")
            sut.setValue(tableView, forKey: "tableView")
            tableView.setValue(adapter, forKey: "delegate")
            tableView.setValue(adapter, forKey: "dataSource")
            
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
    
    class StubTransactionListAdapter: TransactionListAdapter {
        
        var adapterCalled = false
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            adapterCalled = true
            return 99
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40
        }
    }

}

