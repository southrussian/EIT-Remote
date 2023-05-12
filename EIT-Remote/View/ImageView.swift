import SwiftUI
import Foundation

struct BMPView: View {
    @State private var bmpData: Data = Data()
    @State private var ipAddress: String = ""
    @State private var portNumber: String = ""
    @State private var showAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("IP-адрес:")
                        .foregroundColor(.mint)
                    TextField("Введите IP-адрес", text: $ipAddress)
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(Color.mint.opacity(0.1)).frame(height: 30)
                        )
                        .padding(.horizontal)
                }
                HStack {
                    Text("Порт:")
                        .foregroundColor(.mint)
                    TextField("Введите номер порта", text: $portNumber)
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(Color.mint.opacity(0.1)).frame(height: 30)
                        )
                        .padding(.horizontal)
                }
                HStack {
                    Button(action: startReceiving) {
                        Text("Получить изображение")
                            .frame(width: 250, height: 30)
                            .background(Color.mint)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding()
                    }
                }
                .padding(15)
                
                Text("")
                Text("")
                Text("")
                if let image = UIImage(data: bmpData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                } else {
                    Text("Изображение пока не принято")
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Ошибка подключения"),
                    message: Text("Неверный IP-адрес или номер порта"),
                    dismissButton: .default(Text("ОК"))
                )
            }
        }
    }


    private func startReceiving() {
        guard let serverAddress = ipAddress as CFString?, let port = UInt32(portNumber) else {
            print("Invalid server address or port")
            showAlert = true
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
            
        var isFirst = true
        var headerData = Data()
        var bytesReadTotal = 0
        var buff = [UInt8](repeating: 0, count: 4)
            
        let _ = stream.read(&buff, maxLength: buff.count)
        let _ = Int(buff[0])
        var bmp: Data = Data()
            //print(size)
        while true {
            var buffer = [UInt8](repeating: 0, count: 49214)
                
            let bytesRead = stream.read(&buffer, maxLength: buffer.count)
            print(buffer)
                
            if bytesRead > 0 {
                bytesReadTotal += bytesRead
                print(bytesReadTotal)
                if isFirst {
                    headerData.append(contentsOf: buffer[8..<62])
                    bmp.append(contentsOf: buffer[62..<bytesRead])
                    isFirst = false
                } else {
                    bmp.append(contentsOf: buffer[0..<bytesRead])
                }
                    
                if isFirst == false && bytesReadTotal == 49214{
                        // The first image has been fully received
                        // Check if header is valid BMP header
                    if headerData.count == 54 && headerData[0] == 0x42 && headerData[1] == 0x4D {
                        print(headerData.count)
                            // BMP header is valid, create UIImage
                            //DispatchQueue.main.async {
                        self.bmpData.removeAll()
                            self.bmpData = headerData + bmp[0...] // Remove header from data
                            print(self.bmpData)
                            //}
                            return
                            //}
                        }
                    }
                } else {
                    print("Stream closed")
                    return
                }
            }
        }


}
