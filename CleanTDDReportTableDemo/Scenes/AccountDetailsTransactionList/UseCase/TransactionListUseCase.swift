//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCase {

    weak var output: TransactionListUseCaseOutput!
    let entityGateway: EntityGateway
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    func eventRefreshTwoSource(transformer: TransactionListRefreshTwoSourceUseCaseTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListRefreshTwoSourceUseCaseTransformer(transactionManager: entityGateway.transactionManager)
        }
        transformer!.transform(output: output)
    }
    
    func eventRefreshOneSource(transformer: TransactionListRefreshOneSourceUseCaseTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListRefreshOneSourceUseCaseTransformer(transactionManager: entityGateway.transactionManager)
        }
        transformer!.transform(output: output)
    }
}

