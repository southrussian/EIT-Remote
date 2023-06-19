//
//  DetProdView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct DetailPatientView: View {
    
    @State var viewModel: PatientDetailsViewModel
//    @State var count = "6 шт"
    @State var frequencyCount = 50
    @State var description = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Image(uiImage: self.viewModel.image)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                        .foregroundColor(.mint)
                    Spacer()
                    Text("\(viewModel.patient.surname) \(viewModel.patient.name)\n\(viewModel.patient.patronym)")
                        .font(.title)
                        .bold()

                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading) {
                    Section(header: Text("Личные данные")) {
                        HStack {
                            Text("Категория: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.category)
                        }
                        HStack {
                            Text("Дата рождения: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.dateOfBirth)
                        }
                        HStack {
                            Text("Пол: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.gender)
                        }
                        HStack {
                            Text("Адрес: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.address)
                        }
                        HStack {
                            Text("СНИЛС: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.snils)
                        }
                        HStack {
                            Text("Полис ОМС: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.polis)
                        }
                        HStack {
                            Text("Серия паспорта: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.passportSerie)
                        }
                        HStack {
                            Text("Номер паспорта: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.passportNumber)
                        }
                    }
                    Section(header: Text("Социальные данные")) {
                        HStack {
                            Text("Категория: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.familyState)
                        }
                        HStack {
                            Text("Образование: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.education)
                        }
                        HStack {
                            Text("Адрес проживания: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.address)
                        }
                        HStack {
                            Text("Место работы: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.jobPlace)
                        }
                    }
                    
                    Section(header: Text("Медицинские показания")) {
                        HStack {
                            Text("Жалобы: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.illnesses)
                        }
                        HStack {
                            Text("Диагноз: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.diagnosis)
                        }
                    }
                    
                    Section(header: Text("Данные устройства ЭИТ")) {
                        HStack {
                            Text("IP-адрес: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.ipAddress)
                        }
                        HStack {
                            Text("Порт: ")
                                .foregroundColor(.mint)
                            Spacer()
                            Text(viewModel.patient.port)
                        }
                    }
                    
                    Section(header: Text("Устройство ЭИТ")) {
                        NavigationLink("Просмотр вентиляции") {
                            let viewModel = VentilationViewModel(patient: viewModel.patient)
                            VentilationView(viewModel: viewModel)
                        }
                    }
                    .foregroundColor(.mint)
                        if viewModel.patient.category == "Болезни дыхательных путей" {
                            HStack {
                                Stepper("Частота тока при исследовании", value: $frequencyCount, in: 50...1000, step: 50)
                                Text("\(self.frequencyCount)")
                                    .padding(.leading)
                            }
                            .padding(.horizontal, 20)
                            .foregroundColor(.mint)

                            Section {
                                VStack {
                                    Text("Запись об исследовании")
                                        .foregroundColor(.mint)
                                    TextEditor(text: $description)
                                        .lineLimit(4)
                                        .multilineTextAlignment(.leading)
                                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity, alignment: .topLeading)
                                }
                            }
                            .padding()

                        }
                        Spacer()
                }
                .padding()
                Button {
                    var position = Position(id: UUID().uuidString,
                                            patient: viewModel.patient,
                                            frequencyCount: self.frequencyCount, description: description)
                    CartViewModel.shared.addPosition(position)
                    print("Данные добавлены в заключение")
                } label: {
                    Text("Добавить к заключению")
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
        .onAppear {
            self.viewModel.getImage()
        }
    }
    
}


struct DetProdView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPatientView(viewModel: PatientDetailsViewModel(patient: Patient(name: "", surname: "", patronym: "", dateOfBirth: "", address: "", snils: "", polis: "", passportSerie: "", passportNumber: "", familyState: "", education: "", jobPlace: "", illnesses: "", diagnosis: "", ipAddress: "", port: "", category: "", gender: "")))
    }
}


