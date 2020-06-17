//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

extension Transaction {
    
    init?(networkedTransaction from: NetworkedTransaction) {
        
        self.init(
            group: from.group,
            date: from.date,
            description: from.description,
            amount: from.amount,
            debit: from.debit
        )
    }
}
