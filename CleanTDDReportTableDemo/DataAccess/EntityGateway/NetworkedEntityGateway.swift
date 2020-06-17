//  Copyright © 2020 Lyle Resnick. All rights reserved.

class NetworkedEntityGateway: EntityGateway {
    lazy var transactionManager = NetworkedTransactionManager() as TransactionManager
}
