//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListViewController: UIViewController, SpinnerAttachable {

    var presenter: TransactionListPresenter! 
    @IBOutlet fileprivate(set) weak var tableView: UITableView!
    var adapter: TransactionListAdapter!
    private var spinnerView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TransactionListConnector(viewController: self).configure()
        adapter = TransactionListAdapter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = adapter
        spinnerView = attachSpinner()
        spinnerView.hidesWhenStopped = true

        presenter.eventRefreshTwoSource()
//        presenter.eventRefreshOneSource()

    }
}

// MARK: - TransactionListPresenterOutput

extension TransactionListViewController: TransactionListPresenterOutput {}
    
// MARK: - TransactionListRefreshPresenterOutput

extension TransactionListViewController: TransactionListRefreshPresenterOutput {
    
    func initialize() {
        DispatchQueue.main.async {
            self.spinnerView.startAnimating()
        }
    }
    
    func showReport(rows: [TransactionListRowViewModel]) {
        DispatchQueue.main.async {
            self.spinnerView.stopAnimating()
            self.adapter.rows = rows
            self.tableView.reloadData()
        }
    }
}

