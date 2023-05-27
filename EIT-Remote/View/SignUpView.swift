////
////  SignUpView.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 24.05.2023.
////
//
//import SwiftUI
//
//struct SignUpView: View {
////    @StateObject var viewModel = SignUpViewModel()
////    @State var message = ""
////    @State var alert = false
////    @Binding var show : Bool
//
//    var body : some View{
//        NavigationView {
//            ZStack {
//                
//                RoundedRectangle(cornerRadius: 30, style: .continuous)
//                    .foregroundStyle(.linearGradient(colors: [Color.theme.background, .mint], startPoint: .topLeading, endPoint: .bottomTrailing))
//                
//                VStack{
//                    Text("EIT Remote\nРегистрация")
//                        .foregroundColor(Color.theme.accent)
//                        .font(.system(size: 40, weight: .bold, design: .default))
//                        .offset(x: -50, y: -50)
//                    
//                    VStack(alignment: .leading){
//                        
//                        VStack(alignment: .leading){
//                            
//                            Text("ФИО").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//                            
//                            HStack{
//                                
//                                TextField("Введите ФИО", text: $viewModel.name)
//                                
//                                if viewModel.name != ""{
//                                    
//                                    Image(systemName: "checkmark").foregroundColor(Color.init(.label))
//                                }
//                                
//                            }
//                            
//                            Divider()
//                            
//                        }.padding(.bottom, 15)
//                        
//                        VStack(alignment: .leading){
//                            
//                            Text("Адрес электронной почты").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
//                            
//                            HStack{
//                                
//                                TextField("Введите адрес электронной почты", text: $viewModel.email)
//                                
//                                if viewModel.email != ""{
//                                    
//                                    Image(systemName: "checkmark").foregroundColor(Color.init(.label))
//                                }
//                                
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
//                            SecureField("Введите пароль", text: $viewModel.pass)
//                            
//                            Divider()
//                        }
//                        
//                    }.padding(.horizontal, 6)
//                    
//                    Button(action: {
//                        viewModel.register()
//                    }) {
//                        
//                        Text("Регистрация").foregroundColor(Color.theme.accent).frame(width: UIScreen.main.bounds.width - 120).padding()
//                        
//                        
//                    }.background(Color.theme.background)
//                        .clipShape(Capsule())
//                        .padding(.top, 45)
//                    
//                }.padding()
//            }
//            .ignoresSafeArea()
//        }
//
//    }
//}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
