//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListRefreshTwoSourceUseCaseTransformer {
    
    private let transactionManager: TransactionManager

    init(transactionManager: TransactionManager) {
        self.transactionManager = transactionManager
    }
    
    func transform(output: TransactionListRefreshUseCaseOutput) {
        
        output.presentInit()

        var grandTotal = 0.0
        DispatchQueue.global(qos: .background).async {
            let semaphore = DispatchSemaphore(value: 0)
            
            func transformResult(group: TransactionGroup) -> (TransactionListManagerResponse) -> Void {
                output.presentHeader(group: group)

                return  { [weak output] result in
                    guard let output = output else { return }
                    grandTotal += self.transform(result: result, group: group, output: output)
                    semaphore.signal()
                }
            }

            self.transactionManager.fetchAuthorizedTransactions(completion: transformResult(group: .authorized))
            if semaphore.wait(timeout: .now() + 5) == .timedOut {
                output.presentNotFoundMessage(group: .authorized)
            }
            
            self.transactionManager.fetchPostedTransactions(completion: transformResult(group: .posted))
            if semaphore.wait(timeout: .now() + 5) == .timedOut {
                output.presentNotFoundMessage(group: .posted)
            }
            output.presentGrandFooter(grandTotal: grandTotal)
            output.presentReport()

        }
    }

    private func transform(result: TransactionListManagerResponse, group: TransactionGroup, output: TransactionListRefreshUseCaseOutput) -> Double {
        
        switch result {
        case .semantic, .failure:
            output.presentNotFoundMessage(group: group)
            return 0.0
        case let .success(transactions):
            var total = 0.0

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
            return total
        }
    }
}
