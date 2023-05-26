//
//  SignInViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 24.05.2023.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var pass = ""
    @Published var message = ""
    
    init() {}
    
    func validate() -> Bool {
        message = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !pass.trimmingCharacters(in: .whitespaces).isEmpty else {
            message = "Пожалуйста, заполните все поля!"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            message = "Некорректный адрес электронной почты"
            return false
        }
        return true
    }
    
    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: pass)
    }
}
