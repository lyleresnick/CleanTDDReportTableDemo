//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListDetailCell: UITableViewCell, TransactionListCell {
    
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    
    func show(row: TransactionListViewModel) {
        
        guard case let .detail( description, amount, odd ) = row else { fatalError("Expected: detail") }
        descriptionLabel.text = description
        amountLabel.text = amount
        setBackgroundColour(odd: odd)
    }
}

