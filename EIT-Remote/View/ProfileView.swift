//
//  ProfileView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//



import SwiftUI

struct ProfileView: View {
    
    @State var isAuthViewPresented = false
    @State var isQuitAlertShow = false
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Личный кабинет")
                    .foregroundColor(.mint)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.horizontal, 20)
                    .hAligh(.leading)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            TextField("Ваша фамилия", text: $viewModel.profile.surname)
                                .font(.system(size: 16, weight: .semibold))
                            TextField("Ваше имя", text: $viewModel.profile.name)
                                .font(.system(size: 16, weight: .semibold))
                            TextField("Ваше отчество", text: $viewModel.profile.lastName)
                                .font(.system(size: 16, weight: .semibold))
                            HStack {
                                Text("+7")
                                    .font(.system(size: 16, weight: .semibold))
                                TextField("Ваш номер телефона", text: $viewModel.profile.phone)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            TextField("Ваша почта тут", text: $viewModel.profile.email)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .hAligh(.leading)
                        .padding(.horizontal, 20)

                        Divider()
                        //Таблица с заказами
                        Text("Заключения")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.mint)
                            .hAligh(.leading)
                            .padding(.horizontal, 20)
                        if viewModel.orders.count == 0 {
                            Text("У вас нет заключений")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.mint)
                                .hAligh(.center)
                                .padding(.horizontal, 20)
                        } else {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(viewModel.orders, id: \.id) { order in
                                    OrderCell(order: order)
                                }
                            }
                        }
                    }
                    .vAligh(.top)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button ("Выйти", role: .destructive) {
                            AuthService.shared.signOut()
                            isAuthViewPresented.toggle()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.mint)
                    }

                }
            }
            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                AuthView()
            }
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear{
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "",
                                                                   name: "",
                                                                   surname: "",
                                                                   lastName: "",
                                                                   phone: "",
                                                                   email: "")))
    }
}
