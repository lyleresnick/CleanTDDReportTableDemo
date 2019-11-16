//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListCellConfigurator {
    
    private(set) var tableView: UITableView!
    private(set) var indexPath: IndexPath!
    private(set) var presenter: TransactionListPresenter!
    
    func set(tableView: UITableView, indexPath: IndexPath, presenter: TransactionListPresenter) -> Self {
        self.tableView = tableView
        self.indexPath = indexPath
        self.presenter = presenter
        return self;
    }
    
    func show(row: TransactionListViewModel) -> UITableViewCell {
        let cell = tableCell(presenter: presenter)
        (cell as! TransactionListCell).show(row: row)
        return cell
    }
    
    func tableCell(presenter: TransactionListPresenter) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: presenter.cellId(at: indexPath.row), for: indexPath)
    }
}

