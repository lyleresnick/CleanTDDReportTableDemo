//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCaseBeginOneSourceTransformer {
    
    private let allTransactions: [TransactionEntity]?
    
    init(allTransactions: [TransactionEntity]?) {
        self.allTransactions = allTransactions
    }
    
    func transform(presenter: TransactionListUseCaseOutput) {
        
        var grandTotal = 0.0
        presenter.presentInit()

        if let allTransactions = allTransactions {

            var groupStream = ([.authorized, .posted] as [TransactionGroup]).makeIterator()
            var currentGroup = groupStream.next()

            var transactionStream = allTransactions.makeIterator()
            var transaction = transactionStream.next()
            
            var minGroup = determineMinGroup(group: currentGroup, transaction: transaction)
            
            while let localMinGroup = minGroup {

                presenter.presentHeader(group: localMinGroup)
                
                if (transaction == nil) || (localMinGroup != transaction!.group) {
                    
                    presenter.presentNoTransactionsMessage(group: localMinGroup)
                    currentGroup = groupStream.next()
                    minGroup = determineMinGroup(group: currentGroup, transaction: transaction)
                }
                else {
                    var total = 0.0
                    
                    while let localTransaction = transaction, localTransaction.group == localMinGroup {
                        
                        let currentDate = localTransaction.date
                        presenter.presentSubheader(date: currentDate)
                        
                        while let localTransaction = transaction,
                              (localTransaction.group == localMinGroup) && (localTransaction.date == currentDate) {
                            
                            let amount = localTransaction.amount
                            total += amount
                            grandTotal += amount
                            presenter.presentDetail(description: localTransaction.description, amount: amount)
                            
                            transaction = transactionStream.next()
                        }
                        presenter.presentSubfooter()
                    }
                    presenter.presentFooter(total: total)
                    currentGroup = groupStream.next()
                    minGroup = determineMinGroup(group: currentGroup, transaction: transaction)
                }
            }
        }
        else {
            presenter.presentHeader(group: .all)
            presenter.presentNotFoundMessage( group: .all)
        }
        presenter.presentGrandFooter(grandTotal: grandTotal)
        presenter.presentReport()
    }
    
    private func determineMinGroup(group: TransactionGroup?, transaction: TransactionEntity?) -> TransactionGroup? {
        
        if (group == nil) && (transaction == nil) {
            return nil
        }
        else if group == nil {
            return transaction!.group
        }
        else if transaction == nil {
            return group
        }
        else {
            return (group!.rawValue < transaction!.group.rawValue) ? group : transaction!.group
        }
    }
}

