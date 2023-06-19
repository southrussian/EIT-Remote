//
//  ProdDetViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation
import UIKit

class PatientDetailsViewModel: ObservableObject {
    @Published var patient: Patient
//    @Published var count = ["6 шт", "9 шт", "12 шт"]
//    @Published var countOfCorobok = 0
    @Published var image = UIImage(systemName: "person")!
    
    init(patient: Patient) {
        self.patient = patient
        
    }
    func getImage() {
        StorageService.shared.downloadImages(id: patient.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
