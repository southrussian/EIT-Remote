//
//  Task.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 16.01.2023.
//

import Foundation

struct Task: Identifiable {
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDesription: String
    var taskCategory: Category
}
