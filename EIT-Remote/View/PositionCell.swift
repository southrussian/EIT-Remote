//
//  PositionCell.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//
import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("\(position.patient.name) \(position.patient.surname)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.mint)

            }
            Text("Частота: \(position.frequencyCount)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.mint)
            Text("Описание: \(position.description)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.mint)

        }
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString,
                                        patient: Patient(name: "", surname: "", patronym: "", dateOfBirth: "", address: "", snils: "", polis: "", passportSerie: "", passportNumber: "", familyState: "", education: "", jobPlace: "", illnesses: "", diagnosis: "", ipAddress: "", port: "", category: "", gender: ""), frequencyCount: 50, description: ""))
    }
}
