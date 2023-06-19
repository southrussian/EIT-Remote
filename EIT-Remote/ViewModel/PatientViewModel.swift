////
////  PatientViewModel.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 17.01.2023.
////
//
//import Foundation
//import Combine
//import FirebaseFirestore
// 
//class PatientViewModel: ObservableObject {
//   
//  @Published var patient: Patient
//  @Published var modified = false
//   
//  private var cancellables = Set<AnyCancellable>()
//   
//    init(patient: Patient = Patient(name: "", surname: "", patronym: "", dateOfBirth: "", gender: "", address: "", snils: "", polis: "", passportSerie: "", passportNumber: "", familyState: "", education: "", jobStatus: "", jobPlace: "", illnesses: "", diagnosis: "", image: "", category: "", ipAddress: "", port: "")) {
//    self.patient = patient
//     
//    self.$patient
//      .dropFirst()
//      .sink { [weak self] patient in
//        self?.modified = true
//      }
//      .store(in: &self.cancellables)
//  }
//   
//  private var db = Firestore.firestore()
//   
//  private func addPatient(_ patient: Patient) {
//    do {
//      let _ = try db.collection("patients").addDocument(from: patient)
//    }
//    catch {
//      print(error)
//    }
//  }
//   
//  private func updatePatient(_ patient: Patient) {
//    if let documentId = patient.id {
//      do {
//        try db.collection("patients").document(documentId).setData(from: patient)
//      }
//      catch {
//        print(error)
//      }
//    }
//  }
//   
//  private func updateOrAddPatient() {
//    if let _ = patient.id {
//      self.updatePatient(self.patient)
//    }
//    else {
//      addPatient(patient)
//    }
//  }
//   
//  private func removePatient() {
//    if let documentId = patient.id {
//      db.collection("patients").document(documentId).delete { error in
//        if let error = error {
//          print(error.localizedDescription)
//        }
//      }
//    }
//  }
//   
//  func handleDoneTapped() {
//    self.updateOrAddPatient()
//  }
//   
//  func handleDeleteTapped() {
//    self.removePatient()
//  }
//   
//}
//
