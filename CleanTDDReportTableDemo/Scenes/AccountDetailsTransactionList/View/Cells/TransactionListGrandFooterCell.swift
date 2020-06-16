//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListGrandFooterCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var totalLabel: UILabel!
    
    func show(row: TransactionListRowViewModel) {
        
        guard case let .grandfooter(total) = row else { fatalError("Expected: grandfooter") }
        totalLabel.text = total
    }
}
