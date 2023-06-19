//
//  OrderDetViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation

class OrderDetailViewModel: ObservableObject {
    @Published var order: Order
    @Published var user = UserModel(id: "", name: "", surname: "", lastName: "", phone: "", email: "")
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        DatabaseService.shared.getProfile(by: order.userID) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
