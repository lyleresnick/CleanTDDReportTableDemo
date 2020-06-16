//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListPresenter {
    
    weak var output: TransactionListPresenterOutput!
    
    static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )

    private var rows = [TransactionListRowViewModel]()
    private var odd = false
    
    private let useCase: TransactionListUseCase
    
    init(useCase: TransactionListUseCase) {
        self.useCase = useCase
    }

    func eventViewReady() {
        useCase.eventViewReady()
    }
}


// MARK: TransactionListUseCaseOutput

extension TransactionListPresenter: TransactionListUseCaseOutput {}

// MARK: TransactionListViewReadyUseCaseOutput

extension TransactionListPresenter: TransactionListViewReadyUseCaseOutput {
    
    func presentInit() {
        odd = false
        rows.removeAll()
    }

     func presentReport() {
        output.showReport(rows: rows)
    }

    func presentHeader(group: TransactionGroup) {
        rows.append(.header(title: group.toString() + " Transactions"));
    }
    
    func presentSubheader(date: Date) {
        
        odd = !odd;
        rows.append(.subheader(title: formatDate(date: date), odd: odd))
    }
    
    fileprivate func formatDate(date: Date) -> String {
        return TransactionListPresenter.outboundDateFormatter.string(from: date)
    }
    
    func presentDetail(description: String, amount: Double) {
        
        rows.append(.detail(description: description, amount: amount.asString, odd: odd));
    }
    
    func presentSubfooter() {
        
        rows.append(.subfooter(odd: odd));
    }
    
    func presentFooter(total: Double) {
        
        odd = !odd;
        rows.append(.footer(total: total.asString, odd: odd));
    }
    
    func presentGrandFooter(grandTotal: Double) {
        
        rows.append(.grandfooter(total: grandTotal.asString));
    }
    
    func presentNotFoundMessage(group: TransactionGroup) {
    
        rows.append(.message(message: "\(group.toString()) Transactions are not currently available."))
    }
    
    func presentNoTransactionsMessage(group: TransactionGroup) {
        
        rows.append(.message(message: "There are no \(group.toString()) Transactions in this period" ));
    }
    
    func presentNotFoundMessage() {
        
        rows.append(.header(title: "All"))
        rows.append(.message(message: "Transactions are not currently available."))
    }

}


//MARK: -

private extension Double {
    var asString: String {
        return String(format: "%0.2f", self)
    }
}

