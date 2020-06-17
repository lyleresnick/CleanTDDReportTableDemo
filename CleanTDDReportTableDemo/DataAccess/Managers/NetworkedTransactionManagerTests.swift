//  Copyright © 2020 Lyle Resnick. All rights reserved.

import XCTest
@testable import CleanTDDReportTableDemo

class NetworkedTransactionManagerTests: XCTestCase {

    var sut: NetworkedTransactionManager!
    
    override func setUp()  {
        super.setUp()
        
        sut = NetworkedTransactionManager(session: FakeURLSession())
    }

    override func tearDownWithError() throws {
    }

    func testfetchPosted() {
        var result = [Transaction]()
        
        sut.fetchPostedTransactions { response in
            if case let .success(successResult) = response {
                result = successResult
            }
        }
        XCTAssertEqual(TestTransactionManager.postedData, result)
    }
    
    func testfetchAuthorized() {
        var result = [Transaction]()
        
        sut.fetchAuthorizedTransactions { response in
            if case let .success(successResult) = response {
                result = successResult
            }
        }
        XCTAssertEqual(TestTransactionManager.authorizedData, result)
    }

    func testfetchAll() {
        var result = [Transaction]()
        
        sut.fetchAllTransactions { response in
            if case let .success(successResult) = response {
                result = successResult
            }
        }
        XCTAssertEqual(TestTransactionManager.allData, result)
    }



}


class FakeURLSession: URLSession {
    
    private let formatter = DateFormatter.dateFormatter( format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }()
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    
        let lastPartOfPath = url.path.split(separator: "/").last
        
        let transactions: [Transaction]
        switch lastPartOfPath {
        case "authorized":
            transactions = TestTransactionManager.authorizedData
        case "posted":
            transactions = TestTransactionManager.postedData
        case "all":
            transactions = TestTransactionManager.allData
        default:
            fatalError("Unknown Endpoint: '\(String(describing: lastPartOfPath))'")
        }
        
        let networkedTransactions = transactions.map { NetworkedTransaction(transaction: $0) }
        let jsonTransactions: Data
        do {
            jsonTransactions = try encoder.encode(networkedTransactions)
        }
        catch {
            fatalError("JSON: error encoding 'NetworkedTransaction'")
        }
        completionHandler(jsonTransactions, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        
        return URLSessionDataTask()
    }

}


extension NetworkedTransaction {
    
    init?(transaction from: Transaction) {
        let amount = (from.amount >= 0.0 ? from.amount : from.amount * -1).asString
        let debit = from.amount >= 0.0 ? "D" : "C"

        self.init(
            group: from.group.rawValue,
            date: from.date,
            description: from.description,
            amount: amount,
            debit: debit
        )
    }
}
