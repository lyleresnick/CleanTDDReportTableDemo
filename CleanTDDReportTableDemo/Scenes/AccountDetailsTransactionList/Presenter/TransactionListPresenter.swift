//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class TransactionListPresenter {
    
    weak var output: TransactionListPresenterOutput!
    
    static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )

    fileprivate var rows = [TransactionListViewModel]()
    fileprivate var odd = false
    
    private let useCase: TransactionListUseCase
    
    init(useCase: TransactionListUseCase) {
        self.useCase = useCase
    }

    func eventViewReady() {
        useCase.begin()
    }
    
    func cellId(at index: Int) -> String {
        return rows[ index ].cellId
    }
    
    func cellHeight(at index: Int) -> CGFloat {
        return rows[ index ].height
    }
    
    var rowCount: Int { return rows.count }
    
    func row(at index: Int) -> TransactionListViewModel { return rows[ index ] }
}

// MARK: TransactionListUseCaseOutput

extension TransactionListPresenter: TransactionListUseCaseOutput {
    
    func presentInit() {
        odd = false
        rows.removeAll()
    }

     func presentReport() {
        output.showReport()
    }

    func presentHeader(group: TransactionGroup) {
        
        rows.append(.header(title: group.toString() + " Transactions"));
    }
    
    func presentSubheader(date: Date) {
        
        odd = !odd;
        rows.append(.subheader(title: formatDate(date: date), odd: odd))
    }
    
    fileprivate func formatDate(date: Date) -> String {
        return TransactionListPresenter.outboundDateFormatter.string(from: date)
    }
    
    func presentDetail(description: String, amount: Double) {
        
        rows.append(.detail(description: description, amount: amount.asString, odd: odd));
    }
    
    func presentSubfooter() {
        
        rows.append(.subfooter(odd: odd));
    }
    
    func presentFooter(total: Double) {
        
        odd = !odd;
        rows.append(.footer(total: total.asString, odd: odd));
    }
    
    func presentGrandFooter(grandTotal: Double) {
        
        rows.append(.grandfooter(total: grandTotal.asString));
    }
    
    func presentNotFoundMessage(group: TransactionGroup) {
    
        rows.append(.message(message: "\(group.toString()) Transactions are not currently available."))
    }
    
    func presentNoTransactionsMessage(group: TransactionGroup) {
        
        rows.append(.message(message: "There are no \(group.toString()) Transactions in this period" ));
    }
    
    func presentNotFoundMessage() {
        
        rows.append(.header(title: "All"))
        rows.append(.message(message: "Transactions are not currently available."))
    }

}


//MARK: -

private extension Double {
    var asString: String {
        return String(format: "%0.2f", self)
    }
}

//MARK: -

private extension TransactionListViewModel {
    
    var cellId: String {
        return {
            () -> CellId in
            switch self {
            case .header:
                return .header
            case .subheader:
                return .subheader
            case  .detail:
                return .detail
            case .message:
                return .message
            case .footer:
                return .footer
            case .grandfooter:
                return .grandfooter
            case .subfooter:
                return .subfooter
            }
        } ().rawValue
    }

    private enum CellId: String {
        case header
        case subheader
        case detail
        case subfooter
        case footer
        case grandfooter
        case message
    }

    var height: CGFloat {
        get {
            switch self {
            case .header:
                return 60.0
            case .subheader:
                return 34.0
            case .detail:
                return 18.0
            case .subfooter:
                return 18.0
            case .footer:
                return 44.0
            case .grandfooter:
                return 60.0
            case .message:
                return 100.0
            }
        }
    }
}


