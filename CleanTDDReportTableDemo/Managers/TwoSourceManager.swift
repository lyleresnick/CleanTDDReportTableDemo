//  Copyright © 2017 Lyle Resnick. All rights reserved.

protocol TwoSourceManager: class {
    
    func fetchAuthorizedTransactions() -> [TransactionEntity]?
    func fetchPostedTransactions() -> [TransactionEntity]?
}

