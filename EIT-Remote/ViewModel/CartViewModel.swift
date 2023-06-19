//
//  CartViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation

class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    private init() {}
    
    @Published var positions = [Position]()
    
    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
