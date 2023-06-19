////
////  PatientsViewModel.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 16.01.2023.
////
//
//import Foundation
//import Combine
//import FirebaseFirestore
// 
//class PatientsViewModel: ObservableObject {
//  @Published var patients = [Patient]()
//   
//  private var db = Firestore.firestore()
//  private var listenerRegistration: ListenerRegistration?
//   
//  deinit {
//    unsubscribe()
//  }
//   
//  func unsubscribe() {
//    if listenerRegistration != nil {
//      listenerRegistration?.remove()
//      listenerRegistration = nil
//    }
//  }
//   
//  func subscribe() {
//    if listenerRegistration == nil {
//      listenerRegistration = db.collection("patients").addSnapshotListener { (querySnapshot, error) in
//        guard let documents = querySnapshot?.documents else {
//          print("No documents")
//          return
//        }
//         
//        self.patients = documents.compactMap { queryDocumentSnapshot in
//          try? queryDocumentSnapshot.data(as: Patient.self)
//        }
//      }
//    }
//  }
//   
//  func removePatients(atOffsets indexSet: IndexSet) {
//      let patients = indexSet.lazy.map { self.patients[$0] }
//      patients.forEach { patient in
//          if let documentId = patient.id {
//              db.collection("patients").document(documentId).delete { error in
//                  if let error = error {
//                      print("Unable to remove document: \(error.localizedDescription)")
//          }
//        }
//      }
//    }
//  }
//}
