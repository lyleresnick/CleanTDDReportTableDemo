//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit


class TransactionListConnector {
    
    let viewController: TransactionListViewController
    let presenter: TransactionListPresenter
    let useCase: TransactionListUseCase
    
    init(viewController: TransactionListViewController, useCase: TransactionListUseCase, presenter: TransactionListPresenter) {
        
        self.viewController = viewController
        self.presenter = presenter
        self.useCase = useCase
    }
    
    convenience init(viewController: TransactionListViewController, entityGateway: EntityGateway = EntityGatewayFactory.makeEntityGateway()) {
        
        let useCase = TransactionListUseCase(entityGateway: entityGateway)
        let presenter = TransactionListPresenter(useCase: useCase)
        
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }
    
    func configure() {
        viewController.presenter = presenter
        presenter.output = viewController
        useCase.output = presenter
    }
}
