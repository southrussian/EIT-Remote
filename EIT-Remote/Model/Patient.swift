//
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation
import FirebaseFirestore


struct Patient {
    var id: String
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
    var jobPlace: String
    var illnesses: String
    var diagnosis: String
    var ipAddress: String
    var port: String
    var category: String
    var imageUrl: String = ""


    
    var representation: [String : Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["name"] = self.name
        repres["surname"] = self.surname
        repres["patronym"] = self.patronym
        repres["gender"] = self.gender
        repres["dateOfBirth"] = self.dateOfBirth
        repres["address"] = self.address
        repres["snils"] = self.snils
        repres["polis"] = self.polis
        repres["passportSerie"] = self.passportSerie
        repres["passportNumber"] = self.passportNumber
        repres["familyState"] = self.gender
        repres["education"] = self.education
        repres["jobPlace"] = self.jobPlace
        repres["illnesses"] = self.illnesses
        repres["diagnosis"] = self.diagnosis
        repres["ipAddress"] = self.ipAddress
        repres["port"] = self.port
        repres["category"] = self.category

        
        return repres
    }
    
    internal init(id: String = UUID().uuidString, name: String, surname: String, patronym: String, dateOfBirth: String, address: String, snils: String, polis: String, passportSerie: String, passportNumber: String, familyState: String, education: String, jobPlace: String, illnesses: String, diagnosis: String, ipAddress: String, port: String, category: String, imageUrl: String = "", gender: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronym = patronym
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.imageUrl = imageUrl
        self.address = address
        self.snils = snils
        self.polis = polis
        self.passportSerie = passportSerie
        self.passportNumber = passportNumber
        self.familyState = familyState
        self.education = education
        self.jobPlace = jobPlace
        self.illnesses = illnesses
        self.diagnosis = diagnosis
        self.ipAddress = ipAddress
        self.port = port
        self.category = category
        self.imageUrl = imageUrl

    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
        guard let surname = data["surname"] as? String else { return nil }
        guard let patronym = data["patronym"] as? String else { return nil }
        guard let dateOfBirth = data["dateOfBirth"] as? String else { return nil }
        guard let gender = data["gender"] as? String else { return nil }
        guard let address = data["address"] as? String else { return nil }
        guard let snils = data["snils"] as? String else { return nil }
        guard let polis = data["polis"] as? String else { return nil }
        guard let passportSerie = data["passportSerie"] as? String else { return nil }
        guard let passportNumber = data["passportNumber"] as? String else { return nil }
        guard let familyState = data["familyState"] as? String else { return nil }
        guard let education = data["education"] as? String else { return nil }
        guard let jobPlace = data["jobPlace"] as? String else { return nil }
        guard let illnesses = data["illnesses"] as? String else { return nil }
        guard let diagnosis = data["diagnosis"] as? String else { return nil }
        guard let ipAddress = data["ipAddress"] as? String else { return nil }
        guard let port = data["port"] as? String else { return nil }
        guard let category = data["category"] as? String else { return nil }


        
        self.id = id
        self.name = name
        self.surname = surname
        self.patronym = patronym
        self.dateOfBirth = dateOfBirth
        self.address = address
        self.gender = gender
        self.snils = snils
        self.polis = polis
        self.passportSerie = passportSerie
        self.passportNumber = passportNumber
        self.familyState = familyState
        self.education = education
        self.jobPlace = jobPlace
        self.illnesses = illnesses
        self.diagnosis = diagnosis
        self.ipAddress = ipAddress
        self.port = port
        self.category = category
 
    }
}
