//
//  VentilationViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 01.06.2023.
//

import Foundation

class VentilationViewModel: ObservableObject {
    @Published var patient: Patient
    
    init(patient: Patient) {
        self.patient = patient
    }
}
