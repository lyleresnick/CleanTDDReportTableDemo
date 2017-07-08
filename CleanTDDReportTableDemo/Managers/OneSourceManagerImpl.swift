//  Copyright © 2017 Lyle Resnick. All rights reserved.

class OneSourceManagerImpl: OneSourceManager {
    
    func fetchAllTransactions() -> [TransactionEntity]? {
        return TransactionEntity.allData
    }
}
