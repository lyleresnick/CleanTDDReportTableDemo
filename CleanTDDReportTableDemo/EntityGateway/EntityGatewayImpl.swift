//  Copyright © 2017 Lyle Resnick. All rights reserved.
//

import Foundation


class EntityGatewayImpl: EntityGateway {
    
    var oneSourceManager: OneSourceManager
    var twoSourceManager: TwoSourceManager
    
    init(oneSourceManager: OneSourceManager? = nil, twoSourceManager: TwoSourceManager? = nil) {
        
        if let oneSourceManager = oneSourceManager {
            self.oneSourceManager = oneSourceManager
        }
        else {
            self.oneSourceManager = OneSourceManagerImpl()
        }
        if let twoSourceManager = twoSourceManager {
            self.twoSourceManager = twoSourceManager
        }
        else {
            self.twoSourceManager = TwoSourceManagerImpl()
        }
    }

}

