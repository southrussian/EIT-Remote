////
////  ContentView.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 29.11.2022.
////
//
//import SwiftUI
//import Firebase
//import FirebaseAuth
//
//struct ContentView: View {
//
//    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
////    @EnvironmentObject var viewModel: UserViewModel
//
//    var body: some View {
//        VStack{
//            if status{
//                Tab()
//            }
//            else{
//                SignIn()
//            }
//        }
//        .animation(.spring())
//            .onAppear {
//
//                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
//
//                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//                    self.status = status
//                }
//        }
//    }
//}
//
//
//struct SignIn : View {
//
//    @State var user = ""
//    @State var pass = ""
//    @State var message = ""
//    @State var alert = false
//    @State var show = false
////    @EnvironmentObject var viewModel: UserViewModel
//
//
//    var body : some View{
//        ZStack {
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
//
//            VStack {
//                VStack{
//                    Text("EIT Remote\nВход")
//                        .foregroundColor(Color.theme.accent)
//                        .font(.system(size: 40, weight: .bold, design: .rounded))
//                        .offset(x: -50, y: -50)
//                    VStack(alignment: .leading){
//
//                        VStack(alignment: .leading){
//
//                            Text("Адрес электронной почты").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//
//                            HStack {
//                                TextField("Введите адрес электронной почты", text: $user)
//                                if user != ""{
//                                    Image(systemName: "checkmark").foregroundColor(Color.init(.label))
//                                }
//                            }
//
//                            Divider()
//
//                        }.padding(.bottom, 15)
//
//                        VStack(alignment: .leading){
//
//                            Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//
//                            SecureField("Введите пароль", text: $pass)
//
//                            Divider()
//                        }
//
//                    }.padding(.horizontal, 6)
//
//                    Button(action: {
//
//                        signInWithEmail(email: self.user, password: self.pass) { (verified, status) in
//
//                            if !verified {
//
//                                self.message = status
//                                self.alert.toggle()
//                            }
//                            else{
//
//                                UserDefaults.standard.set(true, forKey: "status")
//                                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                            }
//                        }
//
//
//                    }) {
//
//                        Text("Войти").foregroundColor(Color.theme.accent).frame(width: UIScreen.main.bounds.width - 120).padding()
//                    }.background(Color.theme.background)
//                        .clipShape(Capsule())
//                        .padding(.top, 45)
//
//                }.padding()
//                    .alert(isPresented: $alert) {
//
//                        Alert(title: Text("Ошибка"), message: Text(self.message), dismissButton: .default(Text("Ок")))
//                }
//                VStack{
//
//                    Text("").foregroundColor(Color.theme.secondaryText).padding(.top,30)
//
//
//                    HStack(spacing: 8){
//
//                        Text("Еще нет аккаунта?").foregroundColor(Color.theme.secondaryText)
//
//                        Button(action: {
//
//                            self.show.toggle()
//
//                        }) {
//
//                            Text("Зарегистрироваться")
//
//                        }.foregroundColor(Color.theme.accent)
//
//                    }.padding(.top, 25)
//
//                }.sheet(isPresented: $show) {
//
//                    SignUp(show: self.$show)
//                }
//            }
//        }
//        .ignoresSafeArea()
//    }
//}
//
//struct SignUp : View {
//
//    @State var user = ""
//    @State var pass = ""
//    @State var message = ""
//    @State var alert = false
//    @Binding var show : Bool
//
//    var body : some View{
//        ZStack {
//
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
//
//            VStack{
//                Text("EIT Remote\nРегистрация")
//                    .foregroundColor(Color.theme.accent)
//                    .font(.system(size: 40, weight: .bold, design: .rounded))
//                    .offset(x: -50, y: -50)
//
//                VStack(alignment: .leading){
//
//                    VStack(alignment: .leading){
//
//                        Text("Адрес электронной почты").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//
//                        HStack{
//
//                            TextField("Введите адрес электронной почты", text: $user)
//
//                            if user != ""{
//
//                                Image(systemName: "checkmark").foregroundColor(Color.init(.label))
//                            }
//
//                        }
//
//                        Divider()
//
//                    }.padding(.bottom, 15)
//
//                    VStack(alignment: .leading){
//
//                        Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//
//                        SecureField("Введите пароль", text: $pass)
//
//                        Divider()
//                    }
//
//                }.padding(.horizontal, 6)
//
//                Button(action: {
//
//                    signUpWithEmail(email: self.user, password: self.pass) { (verified, status) in
//
//                        if !verified{
//
//                            self.message = status
//                            self.alert.toggle()
//
//                        }
//                        else{
//
//                            UserDefaults.standard.set(true, forKey: "status")
//
//                            self.show.toggle()
//
//                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                        }
//                    }
//
//                }) {
//
//                    Text("Регистрация").foregroundColor(Color.theme.accent).frame(width: UIScreen.main.bounds.width - 120).padding()
//
//
//                }.background(Color.theme.background)
//                    .clipShape(Capsule())
//                    .padding(.top, 45)
//
//            }.padding()
//                .alert(isPresented: $alert) {
//                    Alert(title: Text("Ошибка"), message: Text(self.message), dismissButton: .default(Text("Ок")))
//            }
//        }
//        .ignoresSafeArea()
//
//    }
//}
//
//
//
//func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void) {
//    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
//        if err != nil{
//            completion(false,(err?.localizedDescription)!)
//            return
//        }
//        completion(true,(res?.user.email)!)
//    }
//}
//
//
//
//
//func signUpWithEmail(email: String, password : String, completion: @escaping (Bool,String)->Void) {
//    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
//        if err != nil{
//            completion(false,(err?.localizedDescription)!)
//            return
//        }
//        completion(true,(res?.user.email)!)
//    }
//}
//
//func updateUserDocument(userID: String, email: String, completion: @escaping (Bool, Error?) -> Void) {
//    let db = Firestore.firestore()
//
//    db.collection("users").document(userID).updateData([
//        "email": email
//        // Другие поля пользователя, которые нужно обновить
//    ]) { error in
//        if let error = error {
//            completion(false, error)
//            return
//        }
//
//        completion(true, nil)
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isAuth = true
    @State private var showTab = false
    @State private var showAlert = false
    @State private var message = ""

    var body: some View {
        VStack {
            if UIDevice.current.userInterfaceIdiom == .pad {
                VStack(alignment: .leading) {
                    Text("EIT Remote")
                        .foregroundColor(Color.theme.accent)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -210, y: -50)
                    Text(isAuth ? "Авторизация" : "Регистрация")
                        .foregroundColor(Color.theme.accent)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -210, y: -50)
                }
                .padding(.horizontal)
            } else {
                VStack(alignment: .leading) {
                    Text("EIT Remote")
                        .foregroundColor(Color.theme.accent)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -50, y: -50)
                    Text(isAuth ? "Авторизация" : "Регистрация")
                        .foregroundColor(Color.theme.accent)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -50, y: -50)
                }
            }
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Адрес электронной почты").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))

                    HStack {
                        TextField("Введите адрес электронной почты", text: $email)
                        if email != "" {
                            Image(systemName: "checkmark").foregroundColor(Color.init(.label))
                        }
                    }
                    Divider()
                }
                .padding(.bottom, 15)

                VStack(alignment: .leading){
                    Text("Пароль").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    SecureField("Введите пароль", text: $password)
                    Divider()
                }
            }.padding(.horizontal, 15)
            
            Button {
                if isAuth {
                    print("Авторизация")
                        AuthService.shared.signIn(email: email, password: password) { result in
                            switch result {
                            case .success(_):
                                showTab.toggle()
                            case .failure(let error):
                                message = "Ошибка авторизации \(error.localizedDescription)"
                                showAlert.toggle()
                            }
                        }
                } else {
                    AuthService.shared.regUser(email: self.email, password: self.password) { result in
                        switch result {
                        case .success:
                            message = "Вы успешно зарегистрировались!"
                            self.showAlert.toggle()
                            self.email = ""
                            self.password = ""
                            self.isAuth.toggle()
                        case .failure(let error):
                            message = "Ошибка регистрации\n \(error.localizedDescription)"
                            self.showAlert.toggle()
                        }
                    }
                    

                }
            } label: {
                Text(isAuth ? "Войти" : "Зарегистрироваться").foregroundColor(Color.theme.accent).frame(width: UIScreen.main.bounds.width - 120).padding()
            }.background(Color.theme.background)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            VStack{
//                Text("").foregroundColor(Color.theme.secondaryText).padding(.top,30)
                HStack(spacing: 8){
                    Text(isAuth ? "Еще нет аккаунта?" : "Уже зарегистрированы?").foregroundColor(Color.theme.secondaryText)
                    Button(action: {
                        isAuth.toggle()
                    }) {
                        Text(isAuth ? "Зарегистрироваться" : "Авторизироваться")
                    }.foregroundColor(Color.theme.accent)
                }.padding(.top, 25)

            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showTab) {
            let tabViewModel = TabViewModel(user: AuthService.shared.currentUser!)
            Tab(viewModel: tabViewModel)
        }
        .alert(message, isPresented: $showAlert) {
            Button {
                self.showAlert.toggle()
            } label: {
                Text("OK")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
