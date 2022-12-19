//
//  LoginView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 19.12.2022.
//

import SwiftUI
import Firebase
import PhotosUI
import FirebaseFirestore
import FirebaseStorage

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.white
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
//                .frame(width: 1000, height: 400)
//                .rotationEffect(.degrees(135))
//                .offset(y: -350)
            
            VStack(spacing: 25) {
                Text("EIT Remote\nВход")
                    .foregroundColor(Color.theme.accent)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -50, y: -50)
                
                TextField("", text: $email)
                    .foregroundColor(Color.theme.accent)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Адрес электронной почты")
                            .foregroundColor(Color.theme.accent)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.theme.accent)
                
                SecureField("", text: $password)
                    .foregroundColor(Color.theme.accent)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Пароль")
                            .foregroundColor(Color.theme.accent)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.theme.accent)
                
                Button(action: loginUser) {
                    Text("Войти")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 320, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.linearGradient(colors: [Color.theme.background], startPoint: .top, endPoint: .bottom))
                        )
                        .foregroundColor(Color.theme.accent)
                        .padding(.top)
                }
                
                Button("Забыли пароль?", action: resetPassword)
                    .font(.callout)
                    .foregroundColor(Color.theme.secondaryText)
                
                HStack {
                    Text("Нет аккаунта?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        createAccount.toggle()
                    } label: {
                        Text("Зарегистрируйтесь")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color.theme.accent)
                    }
                }.offset(y: 150)
                
                
            }
            .frame(width: 350)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func loginUser() {
        Task {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("User is found")
            } catch {
                await setError(error)
            }
        }
    }
    
    func resetPassword() {
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                print("Link is sent")
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userName: String = ""
    @Environment(\.dismiss) var dismiss
    @State var userProfilePicData: Data?
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    @AppStorage("log_status") var logstatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var usernameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View {
        ZStack {
            Color.white
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
//                .frame(width: 1000, height: 400)
//                .rotationEffect(.degrees(135))
//                .offset(y: -350)
            
            VStack(spacing: 25) {
                Text("EIT Remote\nРегистрация")
                    .foregroundColor(Color.theme.accent)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -50, y: -50)
                
                ZStack {
                    if let userProfilePicData, let image = UIImage(data: userProfilePicData) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 85, height: 85)
                .clipShape(Circle())
                .contentShape(Circle())
                .offset(y: -30)
                .onTapGesture {
                    showImagePicker.toggle()
                }
                
                TextField("", text: $userName)
                    .foregroundColor(Color.theme.accent)
                    .textFieldStyle(.plain)
                    .placeholder(when: userName.isEmpty) {
                        Text("Имя пользователя")
                            .foregroundColor(Color.theme.accent)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.theme.accent)
                
                TextField("", text: $email)
                    .foregroundColor(Color.theme.accent)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Адрес электронной почты")
                            .foregroundColor(Color.theme.accent)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.theme.accent)
                
                SecureField("", text: $password)
                    .foregroundColor(Color.theme.accent)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Пароль")
                            .foregroundColor(Color.theme.accent)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(Color.theme.accent)
                
                Button {
                    registerUser()
                } label: {
                    Text("Зарегистрироваться")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 320, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.linearGradient(colors: [Color.theme.background], startPoint: .top, endPoint: .bottom))
                        )
                        .foregroundColor(Color.theme.accent)
                        .padding(.top)
                }
                
                HStack {
                    Text("Уже есть аккаунт?")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        dismiss()
                    } label: {
                        Text("Войдите")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color.theme.accent)
                    }
                }
                
                
            }
            .frame(width: 350)
        }
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .ignoresSafeArea()
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            if let newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else {
                            return
                        }
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    } catch {}
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func registerUser() {
        isLoading = true
        Task {
            do {
                try await Auth.auth().createUser(withEmail: email, password: password)
                guard let userUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else {return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                let downloadURL = try await storageRef.downloadURL()
                
                let user = User(username: userName, userEmail: email, userUID: userUID, userProfileURL: downloadURL)
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: { error in
                    if error == nil {
                        print("Saved successfully")
                        usernameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logstatus = true
                    }
                })
            } catch {
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 0.6 : 0)
                self
            }
    }
}
