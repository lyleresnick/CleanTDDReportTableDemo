//  Created by Lyle Resnick on 2016-08-25.
//  Copyright © 2016 Lyle Resnick. All rights reserved.
//

import Foundation

class TestEntityGateway: EntityGateway {
    var transactionManager: TransactionManager = TestTransactionManager()
}
