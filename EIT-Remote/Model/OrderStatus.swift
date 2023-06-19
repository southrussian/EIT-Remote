//
//  OrderStatus.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    
    case gotResults = "Результаты получены"
    case inProgress = "Результаты обрабатываются"
    case satisfied = "Результаты удовлетворительны"
    case notSatisfied = "Результаты неудовлетворительны"
}
