//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListRefreshOneSourceUseCaseTransformer {
    
    private let transactionManager: TransactionManager

    init(transactionManager: TransactionManager) {
        self.transactionManager = transactionManager
    }

    func transform(output: TransactionListRefreshUseCaseOutput) {
        
        var grandTotal = 0.0
        output.presentInit()

        transactionManager.fetchAllTransactions { [weak output] result in

            guard let output = output else { return }
            
            switch result {
            case .semantic, .failure:
                output.presentNotFoundMessage()
            case let .success(allTransactions):

                var groupStream = [TransactionGroup.authorized, .posted].makeIterator()
                var currentGroup = groupStream.next()

                var transactionStream = allTransactions.makeIterator()
                var transaction = transactionStream.next()
                
                var minGroup = self.determineMinGroup(group: currentGroup, transaction: transaction)
                
                while let localMinGroup = minGroup {

                    output.presentHeader(group: localMinGroup)
                    
                    if (transaction == nil) || (localMinGroup != transaction!.group) {
                        output.presentNoTransactionsMessage(group: localMinGroup)
                        currentGroup = groupStream.next()
                        minGroup = self.determineMinGroup(group: currentGroup, transaction: transaction)
                    }
                    else {
                        var total = 0.0
                        while let localTransaction = transaction, localTransaction.group == localMinGroup {
                            
                            let currentDate = localTransaction.date
                            output.presentSubheader(date: currentDate)
                            
                            while let localTransaction = transaction,
                                  (localTransaction.group == localMinGroup) && (localTransaction.date == currentDate) {
                                
                                let amount = localTransaction.amount
                                total += amount
                                grandTotal += amount
                                output.presentDetail(description: localTransaction.description, amount: amount)
                                
                                transaction = transactionStream.next()
                            }
                            output.presentSubfooter()
                        }
                        output.presentFooter(total: total)
                        currentGroup = groupStream.next()
                        minGroup = self.determineMinGroup(group: currentGroup, transaction: transaction)
                    }
                }
            }
            output.presentGrandFooter(grandTotal: grandTotal)
            output.presentReport()

        }
    }
    
    private func determineMinGroup(group: TransactionGroup?, transaction: Transaction?) -> TransactionGroup? {
        
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

