//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListAdapter: NSObject {
    
    private let cellConfigurator: TransactionListCellConfigurator
    var rows = [TransactionListRowViewModel]()

    
    init(cellConfigurator: TransactionListCellConfigurator = TransactionListCellConfigurator()) {
        self.cellConfigurator = cellConfigurator
    }
}

// MARK: - UITableViewDataSource
extension TransactionListAdapter: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellConfigurator
            .set( tableView: tableView, indexPath: indexPath )
            .show( row: rows[indexPath.row])
        return cell
    }
}
