//
//  DataManager.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 18.12.2022.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var patients: [Patient] = []
    
    init() {
        fetchPatients()
    }
    
    func fetchPatients() {
        patients.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Patients")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    
                    let patient = Patient(id: id, name: name)
                    self.patients.append(patient)
                }
            }
        }
    }
}
