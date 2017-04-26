//  Copyright © 2017 Lyle Resnick. All rights reserved.


import UIKit

protocol TransactionListCell {
    func show( row: TransactionListViewModel )
}

extension TransactionListCell where Self: UITableViewCell {
    
    static var oddBackgroundRGB: Int { return 0xF7F8FC }
    static var evenBackgroundRGB: Int { return 0xDDDDDD }

    func setBackgroundColour(odd: Bool ) {
        
        let backgroundRgb = odd ? Self.oddBackgroundRGB : Self.evenBackgroundRGB
        backgroundColor = UIColor( rgb: backgroundRgb )
    }
}

