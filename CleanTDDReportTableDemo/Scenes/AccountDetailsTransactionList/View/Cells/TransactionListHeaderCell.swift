//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListHeaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    func show(row: TransactionListViewModel) {
        
        guard case let .header(title) = row else { fatalError("Expected: header") }
        titleLabel.text = title
    }
}

