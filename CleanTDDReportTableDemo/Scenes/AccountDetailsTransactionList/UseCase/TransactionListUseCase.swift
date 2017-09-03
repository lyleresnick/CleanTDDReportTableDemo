//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCase {

    weak var output: TransactionListUseCaseOutput!
    let entityGateway: EntityGateway
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    func begin(transformer: TransactionListViewReadyTwoSourceUseCaseTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListViewReadyTwoSourceUseCaseTransformer(transactionManager: entityGateway.twoSourceManager)
        }
        transformer!.transform(output: output)
    }
    
    func beginOneSource(transformer: TransactionListViewReadyOneSourceUseCaseTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            transformer = TransactionListViewReadyOneSourceUseCaseTransformer(transactionManager: entityGateway.oneSourceManager)
        }
        transformer!.transform(output: output)
    }
}

