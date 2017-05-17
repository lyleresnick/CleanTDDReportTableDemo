//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListAdapter: NSObject {
    
    var presenter: TransactionListPresenter!
    fileprivate var cellConfigurator: TransactionListCellConfigurator
    
    // organized to satisfy IB, because it calls init on an ObjC object
    override convenience init() {
        self.init(cellConfigurator: TransactionListCellConfigurator() )
    }
    init(cellConfigurator: TransactionListCellConfigurator ) {
        self.cellConfigurator = cellConfigurator
    }
}

// MARK: - UITableViewDataSource
extension TransactionListAdapter: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cellConfigurator
            .set( tableView: tableView, indexPath: indexPath, presenter: presenter )
            .show( row: presenter.row( at: indexPath.row ))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TransactionListAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.cellHeight(at: indexPath.row)
    }
}

