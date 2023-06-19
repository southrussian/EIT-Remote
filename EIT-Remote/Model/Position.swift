//
//  Position.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//


import Foundation
import FirebaseFirestore

struct Position: Identifiable {
    var id: String
    var patient: Patient
    var frequencyCount: Int
    var description: String

    
    var representation: [String : Any] {
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["frequencyCount"] = frequencyCount
        repres["name"] = patient.name
        repres["surname"] = patient.surname
        repres["description"] = description
        
        return repres
    }
    
    internal init(id: String, patient: Patient, frequencyCount: Int, description: String){
        self.id = id
        self.patient = patient
        self.frequencyCount = frequencyCount
        self.description = description
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
        guard let surname = data["surname"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }

        let patient: Patient = Patient(id: "", name: name, surname: surname, patronym: "", dateOfBirth: "", address: "", snils: "", polis: "", passportSerie: "", passportNumber: "", familyState: "", education: "", jobPlace: "", illnesses: "", diagnosis: "", ipAddress: "", port: "", category: "", gender: "")
        
        guard let frequencyCount = data["frequencyCount"] as? Int else { return nil }
        
        self.id = id
        self.patient = patient
        self.frequencyCount = frequencyCount
        self.description = description
        
    }
}
