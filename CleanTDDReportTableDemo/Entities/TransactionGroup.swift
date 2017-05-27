//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

enum TransactionGroup: String {
    case authorized = "A"
    case posted = "P"
    case all = "0"

    func toString() -> String {
        switch self {
        case .authorized:
            return "Authorized"
        case .posted:
            return "Posted"
        case .all:
            return "All"
        }
    }

    static let groupList: [TransactionGroup] = [.authorized, .posted]
}

