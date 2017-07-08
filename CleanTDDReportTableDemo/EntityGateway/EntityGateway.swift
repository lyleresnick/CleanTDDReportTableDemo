//  Copyright © 2016 Lyle Resnick. All rights reserved.
//

import Foundation

protocol EntityGateway {
    
    var oneSourceManager: OneSourceManager { get }
    var twoSourceManager: TwoSourceManager { get }
}
