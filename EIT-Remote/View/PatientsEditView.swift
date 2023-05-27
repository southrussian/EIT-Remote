//
//  PatientsEditView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 17.01.2023.
//

import SwiftUI
 
enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}
 
struct PatientsEditView: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = PatientViewModel()
  var mode: Mode = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
      Text("Cancel")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
        Form {
            Section(header: Text("Основные сведения о пациенте")) {
                TextField("Фамилия", text: $viewModel.patient.surname)
                TextField("Имя", text: $viewModel.patient.name)
                TextField("Отчество", text: $viewModel.patient.patronym)
                TextField("Дата рождения", text: $viewModel.patient.dateOfBirth)
                TextField("Пол", text: $viewModel.patient.gender)
                TextField("Адрес", text: $viewModel.patient.address)
            }
            Section(header: Text("Документы")) {
                TextField("СНИЛС", text: $viewModel.patient.snils)
                TextField("Полис", text: $viewModel.patient.polis)
                TextField("Серия паспорта", text: $viewModel.patient.passportSerie)
                TextField("Номер паспорта", text: $viewModel.patient.passportNumber)
            }
            Section(header: Text("Дополнительные сведения")) {
                TextField("Семейное положение", text: $viewModel.patient.familyState)
                TextField("Образование", text: $viewModel.patient.education)
                TextField("Трудоустроен(а)", text: $viewModel.patient.jobStatus)
                TextField("Место работы", text: $viewModel.patient.jobPlace)
            }
            Section(header: Text("Медицинские сведения")) {
                TextField("Анамнез", text: $viewModel.patient.illnesses)
                TextField("Диагноз", text: $viewModel.patient.diagnosis)
//                TextField("Устройство ЭИТ", text: $viewModel.patient.device?)
            }
            Section(header: Text("Медицинские сведения")) {
                TextField("Изображение.Ссылка", text: $viewModel.patient.image)
            }


            if mode == .edit {
                Section {
                    Button("Удалить данные пациента") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
          }
        }
      }
      .navigationTitle(mode == .new ? "Добавить пациента" : viewModel.patient.name)
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
      .actionSheet(isPresented: $presentActionSheet) {
        ActionSheet(title: Text("Вы уверены? Это действие нельзя отменить"),
                    buttons: [
                      .destructive(Text("Удалить данные пациента"),
                                   action: { self.handleDeleteTapped() }),
                      .cancel()
                    ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
  func handleDoneTapped() {
    self.viewModel.handleDoneTapped()
    self.dismiss()
  }
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct BookEditView_Previews: PreviewProvider {
  static var previews: some View {
    let patient = Patient(name: "Danil", surname: "Peregorodiev", patronym: "Eugene", dateOfBirth: "02.08.2001", gender: "male", address: "Moscow, Russia", snils: "123456789", polis: "123456789", passportSerie: "0721", passportNumber: "809943", familyState: "Not marriged", education: "High", jobStatus: "Employeed", jobPlace: "SRSPU", illnesses: "Schizophrenia", diagnosis: "Schizophrenia", image: "https://photos5.appleinsider.com/gallery/product_pages/139-hero.jpg", ipAddress: "192.168.0.14", port: "4322")
    let patientViewModel = PatientViewModel(patient: patient)
    return PatientsEditView(viewModel: patientViewModel, mode: .edit)
  }
}
