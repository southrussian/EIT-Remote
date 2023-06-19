//
//  TabViewModel.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation
import FirebaseAuth

class TabViewModel: ObservableObject {
    @Published var user: User
        
        init(user: User) {
            self.user = user
        }
}
