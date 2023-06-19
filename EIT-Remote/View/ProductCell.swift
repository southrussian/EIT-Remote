//
//  ProductCell.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct PatientCell: View {
    var patient: Patient
    
    @State var uiImage = UIImage(systemName: "person.circle")
    
    var body: some View {
        HStack {
            Image(uiImage: uiImage!)
                .resizable()
                .foregroundColor(.mint)
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .padding()
            
                Spacer()
            VStack (alignment: .trailing) {
                HStack(spacing: 3) {
//                    Text(patient.name)
//                        .font(.callout)
                    Text(patient.surname)
                        .font(.callout)
                }
                HStack(spacing: 3) {
                    Text(patient.name)
                        .font(.callout)
                    Text(patient.patronym)
                        .font(.callout)

                }
                
                HStack {
//                    Text("Дата рождения: ")
//                        .font(.system(size: 14, weight: .medium))
//                        .foregroundColor(Color.theme.accent)
                    Text(patient.dateOfBirth)
                        .font(.system(size: 14, weight: .medium))
                        .opacity(0.6)
                }
            }

        }
        .onAppear {
            StorageService.shared.downloadImages(id: self.patient.id) { result in
                switch result {
                    
                case .success(let data):
                    if let img = UIImage(data: data) {
                        self.uiImage = img
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
//        .background(Color.theme.accent)
 
    }
}


struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        PatientCell(patient: Patient(name: "Danil", surname: "Peregorodiev", patronym: "", dateOfBirth: "", address: "", snils: "", polis: "", passportSerie: "", passportNumber: "", familyState: "", education: "", jobPlace: "", illnesses: "", diagnosis: "", ipAddress: "", port: "", category: "", gender: ""))
    }
}
