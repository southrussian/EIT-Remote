//
//  UserViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 26.05.2023.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
            guard let user = user else {
                self?.currentUser = nil
                return
            }
            
            self?.fetchUserDocument(userID: user.uid)
        }
    }
    
    private func fetchUserDocument(userID: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userID).getDocument { [weak self] (snapshot, error) in
            if let document = snapshot, document.exists {
                if let data = document.data(),
                   let email = data["email"] as? String,
                   let password = data["password"] as? String {
                    let user = User(email: email, password: password)
                    self?.currentUser = user
                }
            } else {
                print("Документ не найден: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
