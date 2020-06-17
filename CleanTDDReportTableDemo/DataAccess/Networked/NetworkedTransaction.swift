//  Copyright © 2020 Lyle Resnick. All rights reserved.
//

import Foundation

struct NetworkedTransaction: Codable {
    let group: String
    let date: Date
    let description: String
    let amount: String
    let debit: String
}
