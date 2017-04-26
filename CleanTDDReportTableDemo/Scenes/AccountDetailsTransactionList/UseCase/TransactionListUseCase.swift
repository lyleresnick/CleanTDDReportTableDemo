//  Copyright © 2017 Lyle Resnick. All rights reserved.

import Foundation


class TransactionListUseCase {

    weak var presenter: TransactionListUseCaseOutput!
    private let entityGateway: EntityGateway
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    func begin(transformer: TransactionListUseCaseBeginTwoSourceTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            
            let authorizedTransactions = entityGateway.twoSourceManager.fetchAuthorizedTransactions()
            let postedTransactions = entityGateway.twoSourceManager.fetchPostedTransactions()
            transformer = TransactionListUseCaseBeginTwoSourceTransformer(authorizedTransactions: authorizedTransactions, postedTransactions: postedTransactions)
        }
        transformer!.transform(presenter: presenter)
    }
    
    func beginOneSource(transformer: TransactionListUseCaseBeginOneSourceTransformer? = nil) {
        
        var transformer = transformer
        if transformer == nil {
            
            let allTransactions = entityGateway.oneSourceManager.fetchAllTransactions()
            transformer = TransactionListUseCaseBeginOneSourceTransformer(allTransactions: allTransactions)
        }
        transformer!.transform(presenter: presenter)
    }
}

