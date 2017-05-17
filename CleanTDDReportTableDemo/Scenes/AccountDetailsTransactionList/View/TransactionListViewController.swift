//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListViewController: UIViewController {

    var presenter: TransactionListPresenter! 
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var adapter: TransactionListAdapter!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TransactionListConnector(viewController: self, adapter: adapter).configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.eventViewReady()
    }
}

// MARK: - TransactionListPresenterOutput

extension TransactionListViewController: TransactionListPresenterOutput {
    
    func showReport() {
        tableView.reloadData()
    }
}

