//  Copyright © 2017 Lyle Resnick. All rights reserved.

protocol TransactionListViewReadyPresenterOutput: class {
    func showReport(rows: [TransactionListRowViewModel])
}
