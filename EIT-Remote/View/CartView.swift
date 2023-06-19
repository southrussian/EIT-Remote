//
//  CartView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        VStack{
            Text("Осмотры")
                .hAligh(.leading)
                .padding(.horizontal, 20)
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(.mint)
                .padding(.top, 20)
                .padding(.bottom, 10)
            Text("")
            Text("")
            if viewModel.positions.count == 0 {
                HStack(spacing: 3) {
                    Text("Еще нет осмотров")
                }
                .hAligh(.center)
                .vAligh(.center)
            } else {
                List {
                    ForEach(viewModel.positions, id: \.id) { position in
                        PositionCell(position: position)
                            .swipeActions {
                                Button {
                                    viewModel.positions.removeAll { pos in
                                        pos.id == position.id
                                    }
                                } label: {
                                    Text("Удалить")
                                }.tint(.red)

                            }
                    }
                }
                Button {
                    print("Подтвердить")
                    
                    var order = Order(userID: AuthService.shared.currentUser!.uid,
                                      date: Date(),
                                      status: OrderStatus.gotResults.rawValue)
                    
                    order.positions = self.viewModel.positions
                    
                    DatabaseService.shared.setOrder(order: order) { result in
                        switch result {
                            
                        case .success(let order):
                            print(order)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                } label: {
                    Text("Подтвердить")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 327, height: 72)
                        .cornerRadius(20)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 327, height: 72)
                                .foregroundColor(.mint)
                        }
                }
                
            }
            
        }
        .vAligh(.top)
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct CartTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView(viewModel: CartViewModel.shared)
        }
    }
}
