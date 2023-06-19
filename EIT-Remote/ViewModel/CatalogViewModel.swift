//
//  CatalogViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()
    
    @Published var patients = [Patient]()
    
    func getProducts() {
        DatabaseService.shared.getPatients { result in
            switch result {
                
            case .success(let patient):
                self.patients = patient
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
