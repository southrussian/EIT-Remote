//
//  HomeView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 07.01.2023.
//


import SwiftUI

struct Tab: View {
    
    var viewModel: TabViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                CatalogView()
            }
            .tabItem {
                Image(systemName: "person.text.rectangle")
                    .font(.system(size: 20))
                    .foregroundColor(.mint)
                Text("Пациенты")
                    .foregroundColor(.mint)
            }
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.mint)
                    Text("Осмотры")
                        .foregroundColor(.mint)
                }
            ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "", name: "", surname: "", lastName: "", phone: "", email: "")))
                .tabItem {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.mint)
                    Text("Профиль")
                        .foregroundColor(.mint)
                }
            }
            .tint(.mint)
    }
}
