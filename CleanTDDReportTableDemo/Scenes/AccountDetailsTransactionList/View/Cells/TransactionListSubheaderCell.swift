//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListSubheaderCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    func show(row: TransactionListRowViewModel) {
        
        guard case let .subheader( title, odd ) = row else { fatalError("Expected: subheader") }
        titleLabel.text = title
        setBackgroundColour(odd: odd)
    }
}

