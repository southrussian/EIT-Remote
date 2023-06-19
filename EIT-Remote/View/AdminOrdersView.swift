//
//  AdminOrdersView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State var isOrderViewShow = false
    @State var isAuthView = false
    @State var isShowAddProductView = false
    
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Все осмотры")
                    .foregroundColor(.mint)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                    .hAligh(.leading)
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                            .onTapGesture {
                                viewModel.currentOrder = order
                                isOrderViewShow.toggle()
                            }
                    }
                }
                .onAppear{
                    viewModel.getOrders()
                }

            }
            .vAligh(.top)
            .sheet(isPresented: $isOrderViewShow) {
                let orderViewModel = OrderDetailViewModel(order: viewModel.currentOrder)
                OrderDetailView(viewModel: orderViewModel)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        // Кнопка добавления товара
                        Button {
                            isShowAddProductView.toggle()
                        } label: {
                            Text("Добавить пациента")
                        }
                        // Обновление страницы
                        Button {
                            viewModel.getOrders()
                        } label: {
                            Text("Обновить")
                        }
                        // Выход из аккаунта
                        Button("Выйти", role: .destructive) {
                            AuthService.shared.signOut()
                            isAuthView.toggle()
                        }


                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.mint)
                    }

                }
            }
            .fullScreenCover(isPresented: $isAuthView) {
                AuthView()
            }
            .sheet(isPresented: $isShowAddProductView) {
                AddPatientView()
            }
        }
        
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
