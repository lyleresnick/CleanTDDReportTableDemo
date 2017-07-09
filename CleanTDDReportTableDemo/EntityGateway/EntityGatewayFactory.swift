//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation

class EntityGatewayFactory {
    
    static var gateway: EntityGateway? = nil
    
    static func makeEntityGateway() -> EntityGateway {
        if gateway == nil {
            gateway = EntityGatewayImpl()
        }
        return gateway!
    }
}
