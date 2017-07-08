//  Copyright © 2017 Lyle Resnick. All rights reserved.

protocol OneSourceManager: class {
    func fetchAllTransactions() -> [TransactionEntity]?
}
