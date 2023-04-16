//
//  PatientsListView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//

import SwiftUI
import CachedAsyncImage

struct PatientsListView: View {
    
    @StateObject var viewModel = PatientsViewModel()
    @State var presentAddPatientSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddPatientSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func patientRowView(patient: Patient) -> some View {
          NavigationLink(destination: PatientsDetailsView(patient: patient)) {
              HStack(spacing: 4) {
                  CachedAsyncImage(url: URL(string: patient.image), transaction: Transaction(animation: .easeInOut)) { phase in
                      if let image = phase.image {
                          image
                              .resizable()
                              .scaledToFit()
                              .clipShape(Circle())
                              .frame(width: 80, height: 80)
                              .transition(.opacity)
                      } else {
                          HStack {
                              //
                          }
                      }
                  }
                  VStack(alignment: .leading) {
                      Text(patient.name)
                          .font(.headline)
                      Text(patient.surname)
                          .font(.headline)
                  }
                  
                  Spacer()
                  Text(patient.dateOfBirth)
                      .font(.subheadline)
              }
          }
        }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.patients) { patient in
                    patientRowView(patient: patient)
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Пациенты")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                      print("PatientsListView appears. Subscribing to data updates.")
                      self.viewModel.subscribe()
                    }
            .sheet(isPresented: self.$presentAddPatientSheet) {
                PatientsEditView()
                
            }
        }
        
    }
}

struct PatientsListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsListView()
    }
}
