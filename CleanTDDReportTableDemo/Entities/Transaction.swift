//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

struct Transaction {
    
    var group: TransactionGroup
    var date: Date
    var description: String
    var amount: Double
    
    private static let inboundDateFormatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd")
    
    init( group: String, date: String, description: String, amount: String, debit: String ) {
        
        
        guard let date = Self.inboundDateFormatter.date( from: date )
        else {
            fatalError("Format of Transaction Date is incorrect")
        }
        self.init(group: group, date: date, description: description, amount: amount, debit: debit)
    }
    
    init( group: String, date: Date, description: String, amount: String, debit: String ) {
        
        guard let group = TransactionGroup(rawValue: group)
        else {
            fatalError("Format of Group is incorrect")
        }
        self.group = group
        
        self.date = date
        
        self.description = description
        
        var sign: String
        switch debit
        {
        case "D":
          sign = ""
        case "C":
            sign = "-"
        default:
            fatalError("Format of Transaction Sign is incorrect")
        }

        guard let amount = Double(sign + amount)
        else {
            fatalError("Format of Transaction Amount is incorrect")
        }
        self.amount = amount
    }
}

extension Transaction: Equatable {}
