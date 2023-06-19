////
////  Categories.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 31.05.2023.
////
//
////
////  CategoriesOfDeserts.swift
////  SweetProject
////
////  Created by Андрей Коваленко on 26.05.2023.
////
//
//import SwiftUI
//
//struct CategoriesOfDeserts: View {
//    @StateObject var viewModel = CatalogViewModel()
//
//    var body: some View {
//        VStack {
//            Text("Категории")
//                .hAligh(.leading)
//                .padding(.horizontal, 20)
//                .font(.system(size: 30, weight: .heavy))
//                .foregroundColor(Color.theme.accent)
//            ScrollView(.vertical, showsIndicators: false) {
//                Text("Зефир")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.theme.accent)
//                    .hAligh(.leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(Color.theme.accent)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.deserts.filter{$0.category == "Зефир"}, id: \.id) { item in
//                            NavigationLink  {
//
//                                let viewModel = ProdDetViewModel(product: item)
//
//                                DetProdView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//
//                Text("Торты")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.theme.accent)
//                    .hAligh(.leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(Color.theme.accent)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.deserts.filter{$0.category == "Торты"}, id: \.id) { item in
//                            NavigationLink  {
//
//                                let viewModel = ProdDetViewModel(product: item)
//
//                                DetProdView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//
//                Text("Маршмеллоу")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.theme.accent)
//                    .hAligh(.leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(Color.theme.accent)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.deserts.filter{$0.category == "Маршмеллоу"}, id: \.id) { item in
//                            NavigationLink  {
//
//                                let viewModel = ProdDetViewModel(product: item)
//
//                                DetProdView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//
//                Text("Пирожные")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.theme.accent)
//                    .hAligh(.leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(Color.theme.accent)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.deserts.filter{$0.category == "Пирожные"}, id: \.id) { item in
//                            NavigationLink  {
//
//                                let viewModel = ProdDetViewModel(product: item)
//
//                                DetProdView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//
//                Text("Печенье")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(Color.theme.accent)
//                    .hAligh(.leading)
//                    .padding(.horizontal, 20)
//                    .foregroundColor(Color.theme.accent)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(viewModel.deserts.filter{$0.category == "Печенье"}, id: \.id) { item in
//                            NavigationLink  {
//
//                                let viewModel = ProdDetViewModel(product: item)
//
//                                DetProdView(viewModel: viewModel)
//                            } label: {
//                                ProductCell(product: item)
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        .onAppear{
//            self.viewModel.getProducts()
//        }
//    }
//}
//
//struct CategoriesOfDeserts_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesOfDeserts()
//    }
//}
