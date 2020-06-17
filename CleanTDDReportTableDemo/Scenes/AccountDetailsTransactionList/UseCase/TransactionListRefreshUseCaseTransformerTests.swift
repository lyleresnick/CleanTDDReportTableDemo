//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListRefreshUseCaseTransformerTests: XCTestCase {

    private var presenter: StubTransactionListPresenter!
    private var expectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation()
        presenter = StubTransactionListPresenter(expectation: expectation)

    }

    func test_transformTwoSource_AuthNonePostedNone_mapsCorrectly() {
        
        let sut = TransactionListRefreshTwoSourceUseCaseTransformer(transactionManager: FakeNoneManagerImpl())
        sut.transform(output: presenter)
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(presenter.rows == authNonePostedNoneOutput)
    }


    func test_transformTwoSource_AuthNotFoundPostedNotFound_mapsCorrectly() {
        
        let sut = TransactionListRefreshTwoSourceUseCaseTransformer(transactionManager: FakeNilManagerImpl())
        sut.transform(output: presenter)
        wait(for: [expectation], timeout: 5)

        XCTAssertTrue(presenter.rows == authNotFoundPostedNotFoundOutput)
    }
    
    func test_transformOneSource_AuthNonePostedNone_mapsCorrectly() {
        
        let sut = TransactionListRefreshOneSourceUseCaseTransformer(transactionManager: FakeNoneManagerImpl())
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == authNonePostedNoneOutput)
    }
    
    
    func test_transformOneSource_NotFound_mapsCorrectly() {
        
        let sut = TransactionListRefreshOneSourceUseCaseTransformer(transactionManager: FakeNilManagerImpl())
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == allNotFoundOutput)
    }
    

    static let authorizedData = [
        Transaction( group: "A", date: "2016-04-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-01", description: "Firkin", amount: "15.34", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "A", date: "2016-04-07", description: "TTC", amount: "28.00", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        Transaction( group: "A", date: "2016-04-11", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-11", description: "Pizza Pizza", amount: "33.22", debit: "D" ),
    ]
    
   static let postedData = [
        
        Transaction( group: "P", date: "2016-05-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-02", description: "Shell Steeles West", amount: "44.62", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-05", description: "The Rex", amount: "53.41", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-09", description: "LCBO", amount: "45.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-09", description: "Royal Ontario Museum", amount: "115.60", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-11", description: "Starbucks", amount: "6.21", debit: "D" ),
        Transaction( group: "P", date: "2016-05-11", description: "Domino's Pizza", amount: "33.22", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-12", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-12", description: "PetroGaz Toronto", amount: "80.98", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-15", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        Transaction( group: "P", date: "2016-05-17", description: "Tim Horton's", amount: "4.32", debit: "D" ),
        Transaction( group: "P", date: "2016-05-17", description: "LCBO", amount: "400.55", debit: "D" ),
    ]
    
    func test_transformTwoSource_All_mapsCorrectly() {
        
        let sut = TransactionListRefreshTwoSourceUseCaseTransformer(transactionManager: FakeSomeManagerImpl())
        sut.transform(output: presenter)
        wait(for: [expectation], timeout: 5)

        XCTAssertTrue(presenter.rows == allOutput)
    }

    class FakeSomeManagerImpl: TransactionManager {

        
        func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
            completion(.success(entity: authorizedData))
        }
        func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
            completion(.success(entity: postedData))
        }
        func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
            completion(.success(entity: authorizedData + postedData))
        }
    }

    
    func test_transformOneSource_mapsCorrectly_All() {
        
        let sut = TransactionListRefreshOneSourceUseCaseTransformer(transactionManager: FakeSomeManagerImpl())
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == allOutput)
    }
    
    enum FakeTransactionListViewModel {
        case header
        case subheader
        case detail
        case subfooter
        case footer
        case grandfooter
        case notFoundMessage
        case noTransactionsMessage
        case report
    }

    class StubTransactionListPresenter: TransactionListUseCaseOutput {
        
        let expectation: XCTestExpectation
        
        init(expectation: XCTestExpectation) {
            self.expectation = expectation
        }

        var rows: [FakeTransactionListViewModel] = []

        func presentInit() {
            rows.removeAll()
        }

        func presentHeader(group: TransactionGroup) {
            rows.append(.header)
        }

        func presentSubheader(date: Date) {
            
            rows.append(.subheader)
        }

        func presentDetail(description: String, amount: Double) {
            rows.append(.detail)
        }

        func presentSubfooter() {
            rows.append(.subfooter)
        }

        func presentFooter(total: Double) {
            rows.append(.footer)
        }

        func presentGrandFooter(grandTotal: Double) {
            rows.append(.grandfooter)
        }

        func presentNotFoundMessage(group: TransactionGroup) {
            rows.append(.notFoundMessage)
        }

        func presentNoTransactionsMessage(group: TransactionGroup) {
            rows.append(.noTransactionsMessage)
        }

        func presentNotFoundMessage() {
            rows.append(.header)
            rows.append(.notFoundMessage)
        }

        func presentReport() {
            rows.append(.report)
            expectation.fulfill()
        }
    }

}

private typealias FTLVM = TransactionListRefreshUseCaseTransformerTests.FakeTransactionListViewModel
    
private let tailOutput: [FTLVM] = [.grandfooter, .report]

private let authNotFoundPostedNotFoundOutput: [FTLVM] = [.header, .notFoundMessage, .header, .notFoundMessage ] + tailOutput
private let authNonePostedNoneOutput: [FTLVM] = [.header, .noTransactionsMessage, .header, .noTransactionsMessage] + tailOutput

private let allNotFoundOutput: [FTLVM] = [.header, .notFoundMessage ] + tailOutput

private let authorizedOutput: [FTLVM] = [
    .header,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .footer
]

    
private let postedOutput: [FTLVM] = [
    .header,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .subheader, .detail, .subfooter,
    .subheader, .detail, .detail, .subfooter,
    .footer
]
    
private let allOutput = authorizedOutput + postedOutput +  tailOutput



