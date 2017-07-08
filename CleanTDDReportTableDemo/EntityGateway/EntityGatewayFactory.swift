//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

class EntityGatewayFactory {
    
    static func makeEntityGateway(oneSourceManager: OneSourceManager? = nil, twoSourceManager: TwoSourceManager? = nil) -> EntityGateway {
        return EntityGatewayImpl(oneSourceManager: oneSourceManager, twoSourceManager: twoSourceManager)
    }
}
