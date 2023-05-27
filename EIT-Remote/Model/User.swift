//
//  User.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 24.05.2023.
//

import Foundation

struct User {
    var email: String
    var password: String
    
    // Дополнительные свойства пользователя
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
