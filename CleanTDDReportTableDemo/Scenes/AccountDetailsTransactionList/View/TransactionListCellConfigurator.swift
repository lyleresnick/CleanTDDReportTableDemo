//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListCellConfigurator {
    
    private(set) var tableView: UITableView!
    private(set) var indexPath: IndexPath!
    
    func set(tableView: UITableView, indexPath: IndexPath) -> Self {
        self.tableView = tableView
        self.indexPath = indexPath
        return self;
    }
    
    func show(row: TransactionListRowViewModel) -> UITableViewCell {
        let cell = tableCell(row: row)
        (cell as! TransactionListCell).show(row: row)
        return cell
    }
    
    func tableCell(row: TransactionListRowViewModel) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: row.cellId, for: indexPath)
    }
}

