//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListSubfooterCell: UITableViewCell, TransactionListCell {
    
    func show(row: TransactionListViewModel) {
        
        guard case let .subfooter( odd ) = row else { fatalError("Expected: subfooter") }
        setBackgroundColour(odd: odd);
    }
}

