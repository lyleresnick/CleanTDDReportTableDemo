//  Copyright © 2017 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class TransactionListUseCaseBeginTransformerTests: XCTestCase {

    private var presenter = StubTransactionListPresenter()

    override func setUp() {
        super.setUp()
    }

    func test_transform_TwoSourceAuthNonePostedNone() {
        
        let sut = TransactionListUseCaseBeginTwoSourceTransformer(authorizedTransactions: [], postedTransactions: [])
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == authNonePostedNoneOutput)
    }


    func test_transform_TwoSourceAuthNotFoundPostedNotFound() {
        
        let sut = TransactionListUseCaseBeginTwoSourceTransformer(authorizedTransactions: nil, postedTransactions: nil)
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == authNotFoundPostedNotFoundOutput)
    }
    
    
    func test_transform_OneSourceAuthNonePostedNone() {
        
        let sut = TransactionListUseCaseBeginOneSourceTransformer(allTransactions: [])
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == authNonePostedNoneOutput)
    }
    
    
    func test_transform_OneSourceNotFound() {
        
        let sut = TransactionListUseCaseBeginOneSourceTransformer(allTransactions: nil)
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == allNotFoundOutput)
    }
    

    static let authorizedData = [
        TransactionEntity( group: "A", date: "2016-04-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        TransactionEntity( group: "A", date: "2016-04-01", description: "Firkin", amount: "15.34", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        TransactionEntity( group: "A", date: "2016-04-07", description: "TTC", amount: "28.00", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        TransactionEntity( group: "A", date: "2016-04-11", description: "Starbucks", amount: "3.11", debit: "D" ),
        TransactionEntity( group: "A", date: "2016-04-11", description: "Pizza Pizza", amount: "33.22", debit: "D" ),
    ]
    
   static let postedData = [
        
        TransactionEntity( group: "P", date: "2016-05-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-02", description: "Shell Steeles West", amount: "44.62", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-05", description: "The Rex", amount: "53.41", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-09", description: "LCBO", amount: "45.20", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-09", description: "Royal Ontario Museum", amount: "115.60", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-11", description: "Starbucks", amount: "6.21", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-11", description: "Domino's Pizza", amount: "33.22", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-12", description: "Starbucks", amount: "5.22", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-12", description: "PetroGaz Toronto", amount: "80.98", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-15", description: "Starbucks", amount: "3.11", debit: "D" ),
        
        TransactionEntity( group: "P", date: "2016-05-17", description: "Tim Horton's", amount: "4.32", debit: "D" ),
        TransactionEntity( group: "P", date: "2016-05-17", description: "LCBO", amount: "400.55", debit: "D" ),
    ]
    
    func test_transform_TwoSource() {
        
        let sut = TransactionListUseCaseBeginTwoSourceTransformer(authorizedTransactions: TransactionListUseCaseBeginTransformerTests.authorizedData, postedTransactions: TransactionListUseCaseBeginTransformerTests.postedData)
        sut.transform(output: presenter)
        
        XCTAssertTrue(presenter.rows == allOutput)
    }
    
    func test_transform_OneSource() {
        
        let sut = TransactionListUseCaseBeginOneSourceTransformer(allTransactions: TransactionListUseCaseBeginTransformerTests.authorizedData + TransactionListUseCaseBeginTransformerTests.postedData)
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
        }
    }

}

private typealias FTLVM = TransactionListUseCaseBeginTransformerTests.FakeTransactionListViewModel
    
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



