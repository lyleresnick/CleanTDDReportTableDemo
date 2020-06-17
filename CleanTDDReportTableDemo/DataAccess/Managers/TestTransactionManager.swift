//  Copyright © 2020 Lyle Resnick. All rights reserved.

class TestTransactionManager: TransactionManager {
        
    func fetchAuthorizedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.success(entity: Self.authorizedData))
    }
    
    func fetchPostedTransactions(completion: @escaping (TransactionListManagerResponse) -> ()) {
        completion(.success(entity: Self.postedData))
    }
    
    func fetchAllTransactions(completion: @escaping (TransactionListManagerResponse) -> ())  {
       completion(.success(entity: Self.allData))
    }

    static let authorizedData = [
        
        Transaction( group: "A", date: "2016-04-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-01", description: "Firkin", amount: "15.34", debit: "D" ),
        Transaction( group: "A", date: "2016-04-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "A", date: "2016-04-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "A", date: "2016-04-07", description: "TTC", amount: "28.00", debit: "D" ),
        Transaction( group: "A", date: "2016-04-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "A", date: "2016-04-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-11", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-11", description: "Pizza Pizza", amount: "33.22", debit: "D" ),
        Transaction( group: "A", date: "2016-04-12", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "A", date: "2016-04-12", description: "PetroGaz Ottawa", amount: "80.98", debit: "D" ),
        Transaction( group: "A", date: "2016-04-15", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-17", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "A", date: "2016-04-17", description: "LCBO", amount: "400.55", debit: "D" ),
        Transaction( group: "A", date: "2016-04-19", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "A", date: "2016-04-20", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-20", description: "Mr Greek", amount: "13.25", debit: "D" ),
        Transaction( group: "A", date: "2016-04-20", description: "Payment", amount: "400.00", debit: "C" ),
        Transaction( group: "A", date: "2016-04-21", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-22", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "A", date: "2016-04-25", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-25", description: "Burrito Boyz", amount: "23.49", debit: "D" ),
        Transaction( group: "A", date: "2016-04-27", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "A", date: "2016-04-27", description: "Georges Jazz Bar", amount: "56.49", debit: "D" ),
        Transaction( group: "A", date: "2016-04-29", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "A", date: "2016-04-30", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "A", date: "2016-04-30", description: "Mark's Work Wearhouse", amount: "206.66", debit: "D" )
    ]

    static let postedData = [
        
        Transaction( group: "P", date: "2016-05-01", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-02", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-02", description: "Shell Steeles West", amount: "44.62", debit: "D" ),
        Transaction( group: "P", date: "2016-05-05", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-05", description: "The Rex", amount: "53.41", debit: "D" ),
        Transaction( group: "P", date: "2016-05-07", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "P", date: "2016-05-09", description: "LCBO", amount: "45.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-09", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-09", description: "Royal Ontario Museum", amount: "115.60", debit: "D" ),
        Transaction( group: "P", date: "2016-05-10", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-11", description: "Starbucks", amount: "6.21", debit: "D" ),
        Transaction( group: "P", date: "2016-05-11", description: "Domino's Pizza", amount: "33.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-12", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-12", description: "PetroGaz Toronto", amount: "80.98", debit: "D" ),
        Transaction( group: "P", date: "2016-05-15", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-17", description: "Tim Horton's", amount: "4.32", debit: "D" ),
        Transaction( group: "P", date: "2016-05-17", description: "LCBO", amount: "400.55", debit: "D" ),
        Transaction( group: "P", date: "2016-05-19", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-20", description: "Tim Hortons", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-20", description: "Mr Greek", amount: "13.25", debit: "D" ),
        Transaction( group: "P", date: "2016-05-20", description: "Payment", amount: "400.00", debit: "C" ),
        Transaction( group: "P", date: "2016-05-21", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-22", description: "Starbucks", amount: "5.22", debit: "D" ),
        Transaction( group: "P", date: "2016-05-25", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-25", description: "Burrito Boyz", amount: "23.49", debit: "D" ),
        Transaction( group: "P", date: "2016-05-27", description: "Starbucks", amount: "4.32", debit: "D" ),
        Transaction( group: "P", date: "2016-05-27", description: "Georges Jazz Bar", amount: "56.49", debit: "D" ),
        Transaction( group: "P", date: "2016-05-29", description: "Starbucks", amount: "15.20", debit: "D" ),
        Transaction( group: "P", date: "2016-05-30", description: "Starbucks", amount: "3.11", debit: "D" ),
        Transaction( group: "P", date: "2016-05-30", description: "Mark's Work Wearhouse", amount: "206.66", debit: "D" ),
        ]

    static var allData: [Transaction] { return authorizedData + postedData }

}
