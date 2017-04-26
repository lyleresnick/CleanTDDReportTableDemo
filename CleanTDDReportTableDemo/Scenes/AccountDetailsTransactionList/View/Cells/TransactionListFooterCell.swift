//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var totalLabel: UILabel!
    
    func show(row: TransactionListViewModel) {
        
        guard case let .footer(total, odd) = row else { fatalError("Expected: footer") }
        totalLabel.text = total
        setBackgroundColour(odd: odd)
    }
}

