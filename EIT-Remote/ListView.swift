//
//  ListView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 18.12.2022.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        NavigationView {
            List(dataManager.patients, id: \.id) { patient in
                Text(patient.name)
            }
        }
        .navigationTitle("Пациенты")
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Image(systemName: "plus")
        }))
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
