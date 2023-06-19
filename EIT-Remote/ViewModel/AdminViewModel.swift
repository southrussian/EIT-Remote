//
//  AdminViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "Новый")
    
    func getOrders() {
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPosition(by: order.id) { result in
                        switch result {
                            
                        case .success(let positions):
                            self.orders[index].positions = positions
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
