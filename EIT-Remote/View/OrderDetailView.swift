//
//  OrderDetailView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

//
//  OrderDetailView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct OrderDetailView: View {
    
    @StateObject var viewModel: OrderDetailViewModel
    
    var statuses: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Врач: \(viewModel.user.surname) \(viewModel.user.name) \(viewModel.user.lastName)")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color.theme.accent)
            Text("\(viewModel.order.date)")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color.theme.accent)
            HStack {
                Text("Статус исследования: ")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.mint)
                Picker("Статус исследования", selection: $viewModel.order.status){
                    ForEach(statuses, id: \.self) { status in
                        Text(status)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(Color.theme.accent)
                .onChange(of: viewModel.order.status) { newStatus in
                    DatabaseService.shared.setOrder(order: viewModel.order) { result in
                        switch result {
                        case .success(let order):
                            print(order.status)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear{
            viewModel.getUserData()
        }
        List {
            ForEach(viewModel.order.positions, id: \.id) { position in
                PositionCell(position: position)
                }
            }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(viewModel: OrderDetailViewModel(order: Order(userID: "", date: Date(), status: "Новый")))
    }
}
