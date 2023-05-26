//
//  SignInView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 24.05.2023.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
//    @State var email = ""
//    @State var pass = ""
//    @State var message = ""
//    @State var alert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                VStack {
                    VStack{
                        Text("EIT Remote\nВход")
                            .foregroundColor(Color.theme.accent)
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .offset(x: -50, y: -50)
                        VStack(alignment: .leading){
                            VStack(alignment: .leading) {
                                Text("Адрес электронной почты").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                                
                                HStack {
                                    TextField("Введите адрес электронной почты", text: $viewModel.email)
                                    if viewModel.email != ""{
                                        Image(systemName: "checkmark").foregroundColor(Color.init(.label))
                                    }
                                }
                                
                                Divider()
                                
                            }.padding(.bottom, 15)
                            
                            VStack(alignment: .leading){
                                
                                Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                                
                                SecureField("Введите пароль", text: $viewModel.pass)
                                
                                Divider()
                            }
                            Text("")
                            HStack(alignment: .center) {
                                Spacer()
                                if !viewModel.message.isEmpty {
                                    Text(viewModel.message)
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }
                            
                        }.padding(.horizontal, 6)
                        
                        Button(action: {
                            viewModel.login()
                        }) {
                            
                            Text("Войти").foregroundColor(Color.theme.accent).frame(width: UIScreen.main.bounds.width - 120).padding()
                        }.background(Color.theme.background)
                            .clipShape(Capsule())
                            .padding(.top, 45)
                        
                    }.padding()
                    VStack {
                        Text("").foregroundColor(Color.theme.secondaryText).padding(.top,30)
                        HStack(spacing: 8){
                            Text("Еще нет аккаунта?").foregroundColor(Color.theme.secondaryText)
                            NavigationLink("Зарегистрироваться", destination: SignUpView())
                        }.padding(.top, 25)
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
