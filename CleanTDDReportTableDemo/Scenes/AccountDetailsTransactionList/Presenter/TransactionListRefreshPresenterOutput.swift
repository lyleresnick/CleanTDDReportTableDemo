//  Copyright © 2017 Lyle Resnick. All rights reserved.

protocol TransactionListRefreshPresenterOutput: AnyObject {
    func initialize()
    func showReport(rows: [TransactionListRowViewModel])
}
