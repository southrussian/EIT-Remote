////
////  ImagePDFView.swift
////  EIT-Remote
////
////  Created by Danil Peregorodiev on 20.04.2023.
////
//
//import SwiftUI
//import PDFKit
//
//struct BMPPDFView: View {
//    @State private var bmpData: Data = Data()
//    @State private var ipAddress: String = ""
//    @State private var portNumber: String = ""
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Text("IP-адрес:")
//                TextField("Введите IP-адрес", text: $ipAddress)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//            HStack {
//                Text("Порт:")
//                TextField("Введите номер порта", text: $portNumber)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//            Button("Соединение") {
//                startReceiving()
//            }
//            Text("")
//            Text("")
//            Text("")
//            if let image = UIImage(data: bmpData) {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            } else {
//                Text("Изображение пока не принято")
//            }
//            Button("Создать PDF-документ") {
//                let data = createPDF().dataRepresentation()
//                let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
//                activityViewController.popoverPresentationController?.sourceView = self.view
//                UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
//            }
//        }
//        .padding()
//    }
//    
//    private func startReceiving() {
//        guard let serverAddress = ipAddress as CFString?, let port = UInt32(portNumber) else {
//            print("Invalid server address or port")
//            return
//        }
//        
//        var inputStream: InputStream?
//        var outputStream: OutputStream?
//        Stream.getStreamsToHost(withName: serverAddress as String, port: Int(port), inputStream: &inputStream, outputStream: &outputStream)
//        
//        guard let stream = inputStream else {
//            print("Failed to create stream")
//            return
//        }
//        
//        stream.open()
//        while true {
//            var buffer = [UInt8](repeating: 0, count: 1024)
//            let bytesRead = stream.read(&buffer, maxLength: buffer.count)
//            
//            if bytesRead > 0 {
//                bmpData.append(contentsOf: buffer[0..<bytesRead])
//                if bmpData.count > 54 { // BMP header is 54 bytes
//                    // Extract BMP header
//                    let headerData = bmpData.subdata(in: 0..<54)
//                    
//                    // Check if header is valid BMP header
//                    if headerData.count == 54 && headerData[0] == 0x42 && headerData[1] == 0x4D {
//                        // BMP header is valid, create UIImage
//                        DispatchQueue.main.async {
//                            self.bmpData = headerData + self.bmpData[54...] // Remove header from data
//                        }
//                    }
//                }
//            } else {
//                print("Stream closed")
//                return
//            }
//        }
//    }
//    
//    private func createPDF() -> PDFDocument {
//        let pdf = PDFDocument()
//        let page = PDFPage()
//        pdf.insert(page, at: 0)
//        return pdf
//    }
//}
