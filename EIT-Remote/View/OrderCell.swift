//
//  OrderCell.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct OrderCell: View {
    
    var order: Order
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Дата исследования: \(order.date.dateAndTimeToString())")
                    .font(.system(size: 16, weight: .regular))

                Text("Статус исследования: \(order.status)")
                    .font(.system(size: 16, weight: .regular))
            }
            .hAligh(.leading)
            .padding(.leading, 20)
            .frame(width: 353, height: 104)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foregroundColor(.mint)
            .cornerRadius(10))
        }
    }
}
