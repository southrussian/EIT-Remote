//
//  HomeView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        TabView {
            PatientsListView()
                .tabItem {
                    Image(systemName: "person.text.rectangle")
                    Text("Пациенты")
                }
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar.badge.clock")
                    Text("Осмотры")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
            BMPView()
                .tabItem {
                    Image(systemName: "lungs")
                    Text("Картинка")
                }
            StreamView()
                .tabItem {
                    Image(systemName: "lungs")
                    Text("Трансляция")
                }
//            ArrayView()
//                .tabItem {
//                    Image(systemName: "lungs")
//                    Text("Картинка")
//                }
        }
        .accentColor(.mint)
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
