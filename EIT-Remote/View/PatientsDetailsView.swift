//
//  PatientsDetailsView.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 17.01.2023.
//

import SwiftUI
import CachedAsyncImage
 
struct PatientsDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var patient: Patient
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Изменить")
    }
  }
   
  var body: some View {
    Form {
      Section(header: Text("Основные сведения о пациенте")) {
          HStack {
              Text("Фамилия:")
              Spacer()
              Text(patient.surname)
          }
          HStack {
              Text("Имя:")
              Spacer()
              Text(patient.name)
          }
          HStack {
              Text("Отчество:")
              Spacer()
              Text(patient.patronym)
          }
          HStack {
              Text("Дата рождения:")
              Spacer()
              Text(patient.dateOfBirth)
          }
          HStack {
              Text("Пол:")
              Spacer()
              Text(patient.gender)
          }
          HStack {
              Text("Адрес:")
              Spacer()
              Text(patient.address)
          }
      }
       
      Section(header: Text("Документы")) {
          HStack {
              Text("СНИЛС:")
              Spacer()
              Text(patient.snils)
          }
          HStack {
              Text("Полис:")
              Spacer()
              Text(patient.polis)
          }
          HStack {
              Text("Серия паспорта:")
              Spacer()
              Text(patient.passportSerie)
          }
          HStack {
              Text("Номер паспорта:")
              Spacer()
              Text(patient.passportNumber)
          }
      }
        
        Section(header: Text("Дополнительные сведения")) {
            HStack {
                Text("Семейное положение:")
                Spacer()
                Text(patient.familyState)
            }
            HStack {
                Text("Образование:")
                Spacer()
                Text(patient.education)
            }
            HStack {
                Text("Трудоустроен(а):")
                Spacer()
                Text(patient.jobStatus)
            }
            HStack {
                Text("Место работы:")
                Spacer()
                Text(patient.jobPlace)
            }
        }
        
        Section(header: Text("Медицинские сведения")) {
            HStack {
                Text("Анамнез:")
                Spacer()
                Text(patient.illnesses)
            }
            HStack {
                Text("Диагноз:")
                Spacer()
                Text(patient.diagnosis)
            }
            HStack {
                Text("IP-адрес ЭИТ:")
                Spacer()
                Text(patient.ipAddress ?? "")
            }
            HStack {
                Text("Порт ЭИТ:")
                Spacer()
                Text(patient.port ?? "")
            }
        }
        
      Section(header: Text("Photo")) {
          CachedAsyncImage(url: URL(string: patient.image), transaction: Transaction(animation: .easeInOut)) { phase in
              if let image = phase.image {
                  image
                      .resizable()
                      .scaledToFit()
                      .clipShape(RoundedRectangle(cornerRadius: 10))
                      .frame(width: 300, height: 190)
                      .transition(.opacity)
              } else {
                  HStack {
                      //
                  }
              }
          }
      }
        NavigationLink(destination: VentilationView(patient: patient)) {
            Text("Просмотр визуализации")
                .foregroundColor(Color.theme.accent)
        }
    }
    .navigationBarTitle("\(patient.name) \(patient.surname)")
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("PatientsDetailsView.onAppear() for \(self.patient.name)")
    }
    .onDisappear() {
      print("PatientsDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
        PatientsEditView(viewModel: PatientViewModel(patient: patient), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
   
}
 
struct PatientsDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    let patient = Patient(name: "Danil", surname: "Peregorodiev", patronym: "Eugene", dateOfBirth: "02.08.2001", gender: "male", address: "Moscow, Russia", snils: "123456789", polis: "123456789", passportSerie: "0721", passportNumber: "809943", familyState: "Not marriged", education: "High", jobStatus: "Employeed", jobPlace: "SRSPU", illnesses: "Schizophrenia", diagnosis: "Schizophrenia", image: "https://photos5.appleinsider.com/gallery/product_pages/139-hero.jpg", ipAddress: "192.168.0.14", port: "4322")
    return
      NavigationView {
        PatientsDetailsView(patient: patient)
      }
  }
}
