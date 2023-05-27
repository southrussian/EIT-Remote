//
//  Patients.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 10.01.2023.
//

import Foundation
import FirebaseFirestoreSwift


struct Patient: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var surname: String
    var patronym: String
    var dateOfBirth: String
    var gender: String
    var address: String
    var snils: String
    var polis: String
    var passportSerie: String
    var passportNumber: String
    var familyState: String
    var education: String
    var jobStatus: String
    var jobPlace: String
    var illnesses: String
    var diagnosis: String
    var image: String
    var ipAddress: String?
    var port: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case patronym
        case dateOfBirth = "dob"
        case gender
        case address
        case snils
        case polis
        case passportSerie = "passport_serie"
        case passportNumber = "passport_num"
        case familyState = "family_state"
        case education
        case jobStatus = "job_status"
        case jobPlace = "job_place"
        case illnesses
        case diagnosis
        case image
        case ipAddress
        case port
    }
}

//enum Gender: String, CaseIterable, Codable {
//    case boy = "Мужчина"
//    case girl = "Женщина"
//}
//
//enum FamilyState: String, CaseIterable, Codable {
//    case married = "В браке"
//    case notMarried = "Не в браке"
//}
//
//enum JobStatus: String, CaseIterable, Codable {
//    case employeed = "Трудоустроен"
//    case notEmployeed = "Не трудоустроен"
//}
//
//enum Education: String, CaseIterable, Codable {
//    case employeed = "Трудоустроен"
//    case notEmployeed = "Не трудоустроен"
//}
