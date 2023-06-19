//
//  AuthService.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//


import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    private let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    func signOut() {
        try! auth.signOut()
    }
    
    func regUser(email: String,
                 password: String,
                 completion: @escaping (Result<User, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result {
                
                let userModel = UserModel(id: result.user.uid,
                                          name: "",
                                          surname: "",
                                          lastName: "",
                                          phone: "",
                                          email: result.user.email ?? "")
                DatabaseService.shared.setProfile(user: userModel) { resultDB in
                    switch resultDB {
                        
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(email: String,
                     password: String,
                     completion: @escaping (Result<User, Error>) -> ()) {
            auth.signIn(withEmail: email, password: password) { result, error in
                if let result = result {
                    completion(.success(result.user))
                } else if let error = error {
                    completion(.failure(error))
                }
            }
        }
}
