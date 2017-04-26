//  Copyright © 2017 Lyle Resnick. All rights reserved.

class OneSourceManager {
    
    func fetchAllTransactions() -> [TransactionEntity]? {
        return TransactionEntity.allData
    }
}
