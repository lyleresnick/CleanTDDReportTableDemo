//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

protocol TransactionListUseCaseOutput: class {
    
    func presentInit()
    func presentHeader(group: TransactionGroup)
    func presentSubheader(date: Date)
    func presentDetail(description: String, amount: Double)
    func presentSubfooter()
    func presentFooter(total: Double)
    func presentGrandFooter(grandTotal: Double)
    func presentNotFoundMessage(group: TransactionGroup)
    func presentNoTransactionsMessage(group: TransactionGroup)
    
    func presentReport()
}
