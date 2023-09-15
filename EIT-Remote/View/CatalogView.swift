//
//  CatalogView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()
    
    var body: some View {
        VStack {
            Text("Пациенты")
                .hAligh(.leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.mint)
            List {
                ForEach(viewModel.patients, id: \.id) { patient in
                    NavigationLink  {
                        
                        let viewModel = PatientDetailsViewModel(patient: patient)
                        
                        DetailPatientView(viewModel: viewModel)
                    } label: {
                        PatientCell(patient: patient)
                            .padding(.horizontal, 20)
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear{
            self.viewModel.getProducts()
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CatalogView()
        }
    }
}
