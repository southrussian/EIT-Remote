import SwiftUI

struct BMPView: View {
    @State private var bmpData: Data = Data()
    @State private var ipAddress: String = ""
    @State private var portNumber: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("IP-адрес:")
                TextField("Введите IP-адрес", text: $ipAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Порт:")
                TextField("Введите номер порта", text: $portNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button("Соединение") {
                startReceiving()
            }
            Text("")
            Text("")
            Text("")
            if let image = UIImage(data: bmpData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Изображение пока не принято")
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Ошибка подключения"),
                message: Text("Не удалось установить соединение в течение 10 секунд."),
                dismissButton: .default(Text("ОК"))
            )
        }
    }
    
    private func startReceiving() {
        guard let serverAddress = ipAddress as CFString?, let port = UInt32(portNumber) else {
            print("Invalid server address or port")
            return
        }

        var inputStream: InputStream?
        var outputStream: OutputStream?
        Stream.getStreamsToHost(withName: serverAddress as String, port: Int(port), inputStream: &inputStream, outputStream: &outputStream)

        guard let stream = inputStream else {
            print("Failed to create stream")
            return
        }

        stream.open()
        let data = Data([1])
        outputStream?.open()
        let bytesWritten = outputStream?.write([UInt8](data), maxLength: 4)

        if bytesWritten == -1 {
            print("Error sending data")
        } else {
            print("Data sent successfully")
        }
        
        var isFirst: Bool = true
        var headerData: Data = Data()
        var bytesReadTotal = 0
        var timeoutCounter = 0
        
        while true {
            var buffer = [UInt8](repeating: 0, count: 1024)
            let bytesRead = stream.read(&buffer, maxLength: buffer.count)
            print(bytesRead)

            if bytesRead > 0 {
                bytesReadTotal += bytesRead
                if isFirst {
                    headerData.append(contentsOf: buffer[8..<62])
                    self.bmpData.append(contentsOf: buffer[62..<bytesRead])
                    isFirst = false
                } else {
                    self.bmpData.append(contentsOf: buffer[0..<bytesRead])
                }

                if isFirst == false && bytesReadTotal == self.bmpData.count {
                    // The first image has been fully received
                    print(headerData)

                    // Check if header is valid BMP header
                    if headerData.count == 54
                        && headerData[0] == 0x42 && headerData[1] == 0x4D {
                                                print(headerData.count)
                                                // BMP header is valid, create UIImage
                                                //DispatchQueue.main.async {
                                                //self.bmpData = headerData + self.bmpData[0...] // Remove header from data
                                                print(self.bmpData)

                                                //}
                                            }
                                        }
                                    } else if bytesRead == 0 {
                                        print("Stream closed")
                                        return
                                    }
                                    
                                    // Increase the timeout counter
                                    timeoutCounter += 1
                                    
                                    // Check if the timeout limit has been reached (10 seconds)
                                    if timeoutCounter >= 10 {
                                        showAlert = true
                                        return
                                    }
                                }
                            }
                        }
