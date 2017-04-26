//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

enum TransactionGroup: String {
    case Authorized = "A"
    case Posted = "P"
    case All = "0"

    func toString() -> String {
        switch self {
        case .Authorized:
            return "Authorized"
        case .Posted:
            return "Posted"
        case .All:
            return "All"
        }
    }

    static let groupList: [TransactionGroup] = [.Authorized, .Posted]
}

