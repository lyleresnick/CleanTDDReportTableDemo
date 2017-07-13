//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCase {

    weak var output: TransactionListUseCaseOutput!
    let entityGateway: EntityGateway
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    func begin(transformer: TransactionListUseCaseBeginTwoSourceTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListUseCaseBeginTwoSourceTransformer(transactionManager: entityGateway.twoSourceManager)
        }
        transformer!.transform(output: output)
    }
    
    func beginOneSource(transformer: TransactionListUseCaseBeginOneSourceTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListUseCaseBeginOneSourceTransformer(transactionManager: entityGateway.oneSourceManager)
        }
        transformer!.transform(output: output)
    }
}

