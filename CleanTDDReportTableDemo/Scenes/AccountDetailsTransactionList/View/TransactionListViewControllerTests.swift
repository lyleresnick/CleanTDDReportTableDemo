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
        sut = fakeIBLoader.load( sut: TransactionListViewController())
        TransactionListConnector(viewController: sut, useCase: useCase, presenter: stubPresenter).configure()
        sut.adapter = StubTransactionListAdapter()

        _ = sut.view
    }
    
    
    func test_viewDidLoad_SetsAdapter() {
        
        XCTAssertNotNil(sut.adapter)
    }
    
    func test_viewDidLoad_SetsTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource === sut.adapter)
    }
    
    func test_viewDidLoad_CallsPresenterEventRefresh() {
        
        XCTAssertTrue(stubPresenter.refreshCalled)
    }
    
    func test_showReport_CallsTableViewGetRowCount() {
        sut.showReport(rows: [])
        DispatchQueue.main.async {

            let dataSource = self.sut.tableView.dataSource as! StubTransactionListAdapter
            XCTAssertTrue(dataSource.adapterCalled)
        }
    }
        
    // MARK: Stubs

    private class FakeIBLoader {

        let tableView = UITableView()

        func load(sut: TransactionListViewController) -> TransactionListViewController {
            
            sut.setValue(tableView, forKey: "tableView")
            return sut
        }
    }

    class StubTransactionListPresenter: TransactionListPresenter {
        
        var refreshCalled = false
        
        override func eventRefreshTwoSource() {
            refreshCalled = true
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
    }
}

