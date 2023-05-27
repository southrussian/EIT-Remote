////
////  SignUpViewModel.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 24.05.2023.
////
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//
//class SignUpViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var pass = ""
//    @Published var name = ""
//
//    init() {}
//
//    func register() {
//        guard validate() else {
//            return
//        }
//        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] result, error in
//            guard let userId = result?.user.uid else {
//                return
//            }
//            self?.insertUserRecord(id: userId)
//        }
//    }
//
//    private func insertUserRecord(id: String) {
//        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
//        let db = Firestore.firestore()
//        db.collection("users")
//            .document(id)
//            .setData(newUser.asDictionary())
//    }
//
//    private func validate() -> Bool {
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
//              !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !pass.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return false
//        }
//
//        guard email.contains("@") && email.contains(".") else {
//            return false
//        }
//
//        guard pass.count >= 6 else {
//            return false
//        }
//
//        return true
//    }
//}
