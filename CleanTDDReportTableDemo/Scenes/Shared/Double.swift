//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

extension Double {
    var asString: String {
        return String(format: "%0.2f", self)
    }
}
