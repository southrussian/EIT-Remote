//
//  Order.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation
import FirebaseFirestore

struct Order {
    var id: String = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String
    
    var representation: [String : Any] {
        var repres = [String : Any]()
        
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        
        return repres
    }
    
    init(id: String = UUID().uuidString,
         userID: String,
         positions: [Position] = [Position](),
         date: Date,
         status: String){
        self.id = id
        self.userID = userID
        self.positions = positions
        self.date = date
        self.status = status
    }

    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()

        guard let id = data["id"] as? String else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let date = data["date"] as? Timestamp else { return nil }
        guard let status = data["status"] as? String else { return nil }

        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
    }
    
}
