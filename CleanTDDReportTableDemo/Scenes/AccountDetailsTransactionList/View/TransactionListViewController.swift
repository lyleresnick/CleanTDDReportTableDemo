//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListViewController: UIViewController {

    var presenter: TransactionListPresenter! 
    @IBOutlet fileprivate(set) weak var tableView: UITableView!
    var adapter: TransactionListAdapter!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TransactionListConnector(viewController: self).configure()
        adapter = TransactionListAdapter(presenter: presenter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = adapter
        tableView.dataSource = adapter

        presenter.eventViewReady()
    }
}

// MARK: - TransactionListPresenterOutput

extension TransactionListViewController: TransactionListPresenterOutput {}
    
// MARK: - TransactionListViewReadyPresenterOutput

extension TransactionListViewController: TransactionListViewReadyPresenterOutput {
    
    func showReport() {
        tableView.reloadData()
    }
}

