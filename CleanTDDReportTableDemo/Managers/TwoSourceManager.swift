//  Copyright © 2017 Lyle Resnick. All rights reserved.

class TwoSourceManager {
    
    func fetchAuthorizedTransactions() -> [TransactionEntity]? {
        return TransactionEntity.authorizedData
    }
    
    func fetchPostedTransactions() -> [TransactionEntity]? {
        return TransactionEntity.postedData
    }
    
    
}
