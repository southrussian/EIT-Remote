//import SwiftUI
//
//class SocketManager: ObservableObject {
//    @Published var receivedData: [Int] = []
//
//    private var inputStream: InputStream!
//    private var outputStream: OutputStream!
//
//    func connect(serverAddress: String, serverPort: Int) {
//        Stream.getStreamsToHost(withName: serverAddress, port: serverPort, inputStream: &inputStream, outputStream: &outputStream)
//
//        inputStream.open()
//        outputStream.open()
//
//        var buffer = [UInt8](repeating: 0, count: 1024)
//
//        while true {
//            let bytesRead = inputStream.read(&buffer, maxLength: buffer.count)
//
//            if bytesRead > 0 {
//                // Преобразование байтовой строки в массив чисел
//                if let arrayStr = String(bytes: buffer, encoding: .utf8) {
//                    let array = arrayStr.components(separatedBy: ",").compactMap({Int($0.trimmingCharacters(in: .whitespaces))})
//                    // Обновление массива данных и публикация изменений
//                    DispatchQueue.main.async {
//                        self.receivedData = array
//                    }
//                    // Задержка в 5 секунд
//                    Thread.sleep(forTimeInterval: 5)
//                }
//            } else {
//                inputStream.close()
//                outputStream.close()
//                break
//            }
//        }
//    }
//
//    func disconnect() {
//        inputStream.close()
//        outputStream.close()
//    }
//}
//
//struct ArrayView: View {
//    @ObservedObject var socketManager = SocketManager()
//
//    @State private var serverAddress: String = ""
//    @State private var serverPort: String = ""
//    @State private var isConnected = false
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Server Address:")
//                TextField("localhost", text: $serverAddress)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//            HStack {
//                Text("Server Port:")
//                TextField("1234", text: $serverPort)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            }
//            Button(action: {
//                self.isConnected.toggle()
//                if self.isConnected {
//                    self.socketManager.connect(serverAddress: self.serverAddress, serverPort: Int(self.serverPort) ?? 1234)
//                } else {
//                    self.socketManager.disconnect()
//                }
//            }) {
//                Text(self.isConnected ? "Disconnect" : "Connect")
//            }
//            .padding(.top, 10)
//
//            Divider()
//
//            Text("Received data:")
//            Text(socketManager.receivedData.description)
//        }
//    }
//}
