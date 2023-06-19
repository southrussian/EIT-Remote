//
//  AddProductView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 31.05.2023.
//

import SwiftUI

struct AddPatientView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage(systemName: "person.circle")!
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var patronym: String = ""
    @State private var dateOfBirth: String = ""
    @State private var address: String = ""
    @State private var snils: String = ""
    @State private var polis: String = ""
    @State private var passportSerie: String = ""
    @State private var passportNumber: String = ""
    @State private var jobPlace: String = ""
    @State private var illnesses: String = ""
    @State private var ipAddress: String = ""
    @State private var port: String = ""

    
    private var categories = ["Болезни дыхательных путей", "Заболевания легочной ткани", "Болезни легочной циркуляции"]
    private var genders = ["Мужской", "Женский"]
    private var familyState = ["В браке", "Не в браке"]
    private var education = ["Среднее", "Высшее", "Отсутствует"]
    private var diagnosis = ["бронхиальная астма", "хронический бронхит", "хроническая обструктивная болезнь легких", "эмфизема", "легочный фиброз", "саркоидоз", "рак легкого", "плеврит и гидроторакс", "пневмония", "пневмоторакс", "отек легких", "туберкулез легких", "ревматоидные заболевания легких", "окклюзионные заболевания легочных вен"]
    private var country = ["Российская федерация", "Казахстан", "Беларусь", "Армения", "Азербайджан", "Грузия", "Узбекситан", "Таджикистан", "Киргизия"]


    @State private var selectedCategory = "Болезни дыхательных путей"
    @State private var selectedGender = "Мужской"
    @State private var selectedFamilyState = "Не в браке"
    @State private var selectedEducation = "Отсутствует"
    @State private var selectedDiagnosis = "бронхиальная астма"
    @State private var selectedCountry = "Российская федерация"


    
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Добавление данных пациента")
                    .hAligh(.leading)
                    .padding(.horizontal, 20)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.mint)
                    .padding()
                VStack (spacing: 8) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(20)
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Имя: ")
                            TextField("Имя", text: $name)
                        }
                        HStack {
                            Text("Фамилия: ")
                            TextField("Фамилия", text: $surname)
                        }
                        HStack {
                            Text("Отчество: ")
                            TextField("Отчество", text: $patronym)
                        }
                        HStack {
                            Text("Дата рождения: ")
                            TextField("Дата рождения", text: $dateOfBirth)
                        }
                        HStack {
                            Text("Пол: ")
                            Picker("Пол", selection: $selectedGender) {
                                ForEach(genders, id: \.self) { gender in
                                    Text(gender)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.mint)
                        }
                        HStack {
                            Text("СНИЛС: ")
                            TextField("СНИЛС", text: $snils)
                        }
                        HStack {
                            Text("Полис ОМС: ")
                            TextField("Полис ОМС", text: $polis)
                        }
                        HStack {
                            Text("Серия паспорта: ")
                            TextField("Серия паспорта", text: $passportSerie)
                        }
                        HStack {
                            Text("Номер паспорта: ")
                            TextField("Номер паспорта", text: $passportNumber)
                        }
                        HStack {
                            Text("Адрес проживания: ")
                            TextField("Адрес проживания", text: $address)
                        }
                        
                    }
                    .padding()
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Место работы/учебы: ")
                            TextField("Место работы/учебы", text: $jobPlace)
                        }
                        HStack {
                            Text("Семейное положение: ")
                            Picker("Семейное положение", selection: $selectedFamilyState) {
                                ForEach(familyState, id: \.self) { state in
                                    Text(state)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.mint)
                        }
                        HStack {
                            Text("Образование: ")
                            Picker("Образование", selection: $selectedEducation) {
                                ForEach(education, id: \.self) { edu in
                                    Text(edu)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.mint)
                        }
                        HStack {
                            Text("Жалобы: ")
                            TextField("Жалобы", text: $illnesses)
                        }
                        HStack {
                            Text("Диагноз: ")
                            Picker("Диагноз", selection: $selectedDiagnosis) {
                                ForEach(diagnosis, id: \.self) { diag in
                                    Text(diag)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(.mint)
                        }
                        HStack {
                            Text("IP-адрес (ЭИТ): ")
                            TextField("IP-адрес (ЭИТ)", text: $ipAddress)
                        }
                        HStack {
                            Text("Порт (ЭИТ): ")
                            TextField("Порт (ЭИТ)", text: $port)
                        }
                    }
                    .padding()
                    Button {

                        let patient = Patient(id: UUID().uuidString, name: name, surname: surname, patronym: patronym, dateOfBirth: dateOfBirth, address: address, snils: snils, polis: polis, passportSerie: passportSerie, passportNumber: passportNumber, familyState: selectedFamilyState, education: selectedEducation, jobPlace: jobPlace, illnesses: illnesses, diagnosis: selectedDiagnosis, ipAddress: ipAddress, port: port, category: selectedCategory, gender: selectedGender)
                        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
                            print("Невозможно извлечь изображение")
                            return
                        }
                        DatabaseService.shared.setPatient(patient: patient, image: imageData) { result in
                            switch result {
                                
                            case .success(let patient):
                                print(patient.name)
                                dismiss()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                    } label: {
                        Text("Добавить данные пациента")
                            .frame(width: 327,
                                   height: 72)
                            .background(Color.theme.background)
                            .foregroundColor(.mint)
                            .font(.system(size: 18, weight: .medium))
                            .cornerRadius(20.0)
                            .padding(.bottom, 19)
                            .padding(.top, 19)
                    }
                    .padding(.horizontal, 20)
                }
                .vAligh(.top)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientView()
    }
}
