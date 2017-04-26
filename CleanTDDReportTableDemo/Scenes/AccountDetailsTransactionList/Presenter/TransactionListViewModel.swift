//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

enum TransactionListViewModel {
    case header(title: String)
    case subheader(title: String, odd: Bool)
    case detail(description: String, amount: String, odd: Bool)
    case subfooter(odd : Bool)
    case footer(total: String, odd: Bool)
    case grandfooter(total: String)
    case message(message: String)
}

