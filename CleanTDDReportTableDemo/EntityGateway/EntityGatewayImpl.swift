//  Copyright © 2017 Lyle Resnick. All rights reserved.
//

import Foundation


class EntityGatewayImpl: EntityGateway {
    
    var oneSourceManager: OneSourceManager = OneSourceManagerImpl()
    var twoSourceManager: TwoSourceManager = TwoSourceManagerImpl()
}

