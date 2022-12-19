//
//  User.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 19.12.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var userEmail: String
    var userUID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userEmail
        case userUID
        case userProfileURL
    }
}
