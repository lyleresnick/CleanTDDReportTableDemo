//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCaseBeginTwoSourceTransformer {
    
    private let authorizedTransactions: [TransactionEntity]?
    private let postedTransactions: [TransactionEntity]?

    init(authorizedTransactions: [TransactionEntity]?, postedTransactions: [TransactionEntity]?) {
        self.authorizedTransactions = authorizedTransactions
        self.postedTransactions = postedTransactions
    }
    
    func transform(output: TransactionListUseCaseOutput) {
        
        output.presentInit()

        var grandTotal = 0.0
        grandTotal += transform(transactions: authorizedTransactions, group: .authorized, output: output)
        grandTotal += transform(transactions: postedTransactions, group: .posted, output: output)
        output.presentGrandFooter(grandTotal: grandTotal)

        output.presentReport()
    }

    private func transform(transactions: [TransactionEntity]?, group: TransactionGroup, output: TransactionListUseCaseOutput) -> Double {
        
        var total = 0.0

        output.presentHeader(group: group)
        
        if let transactions = transactions {

            if transactions.count == 0 {
                output.presentNoTransactionsMessage(group: group)
            }
            else {
                var transactionStream = transactions.makeIterator()
                var transaction = transactionStream.next()
                
                while let localTransaction = transaction {
                    
                    let currentDate = localTransaction.date
                    output.presentSubheader(date: currentDate)
                    
                    while let localTransaction = transaction,
                          localTransaction.date == currentDate {
                        
                        total += localTransaction.amount
                        output.presentDetail(description: localTransaction.description, amount: localTransaction.amount)
                        transaction = transactionStream.next()
                    }
                    output.presentSubfooter()
                }
                output.presentFooter(total: total)
            }
        }
        else {
            output.presentNotFoundMessage(group: group)
        }

        return total
    }
}
