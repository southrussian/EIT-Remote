//
//  SettingsView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//

import SwiftUI

struct SettingsView: View {
    let vkURL = URL(string: "https://vk.com/south.russian")!
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Об авторе")) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image("Icon")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            Text("EIT Remote")
                                .foregroundColor(Color.theme.accent)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        Text("Приложение выполнено в рамках выпускной квалификационной работы. Разработчик: Перегородиев Данил Евгеньевич - студент кафедры ИИСТ Южно-Российского государственного политехнического университета (НПИ) им. М. И. Платова")
                            .font(.callout)
                            .foregroundColor(Color.theme.accent)
                    }
                    .padding(.vertical)
                    Link("Страница разработчика в VK 💻", destination: vkURL)
                }
                            Button(action: {
                                UserDefaults.standard.set(false, forKey: "status")
                                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            }) {
                                Text("Выйти")
                                    .foregroundColor(.red)
                            }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Настройки")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
