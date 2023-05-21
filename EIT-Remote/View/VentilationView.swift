import SwiftUI
import Foundation


struct VentilationView: View {
    @State private var bmpData: Data = Data()
    @State private var vlData: Data = Data()
    @State private var fhData: Data = Data()
    @State private var ipAddress: String = ""
    @State private var portNumber: String = ""
    @State private var showAlert: Bool = false
    @State private var isReceiving = false
    @State private var timer: Timer?

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Вентиляция")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    Text("")
                }
                .padding(.horizontal)
                HStack {
                    Text("IP-адрес:")
                        .foregroundColor(.mint)
                    TextField("Введите IP-адрес", text: $ipAddress)
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
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(Color.mint.opacity(0.1)).frame(height: 30)
                        )
                        .padding(.horizontal)
                }
                
                if vlData.count >= 2, fhData.count >= 2 {
                    let vlValue = vlData.withUnsafeBytes { $0.load(as: UInt16.self) }
                    let fhValue = fhData.withUnsafeBytes { $0.load(as: UInt16.self) }
                    HStack {
                        Text("VL (%): \((Float(vlValue) / 10.0).clean)")
                            .padding()
                        Text("VR (%): \((100 - (Float(vlValue) / 10.0)).clean)")
                            .padding()
                    }
                    
                } else {
                    Text("Данные вентиляции пока не приняты")
                        .padding()
                }
                

                VStack {
                    Button(action: {
                        if isReceiving {
                            stopReceiving()
                        } else {
                            startReceiving()
                        }
                    }) {
                        Text(isReceiving ? "Остановить получение" : "Получить изображение")
                            .frame(width: 250, height: 30)
                            .background(isReceiving ? .red : .mint)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding()
                    }
//                            .onDisappear {
//                                stopReceiving()
//                            }
                }
                .padding(15)
                
                Text("")
                Text("")

                if let image = UIImage(data: bmpData) {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .padding()
                    } else {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                    }
                    
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
    
    
    func truncateFloat(_ value: Float) -> Float {
        let truncatedValue = round(value * 10) / 10
        return truncatedValue
    }

    
    private func startReceiving() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                // Вызов функции startReceiving
            receiveImage()
        }
    }

    private func stopReceiving() {
        isReceiving = false
        timer?.invalidate()
        timer = nil
    }

    private func receiveImage() {
        isReceiving = true
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
//            var vl = Data()
//            var fh = Data()
        var vl: UInt16 = 0
        var fh: UInt16 = 0
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
            print(buffer[0...7])
                    
            if bytesRead > 0 {
                bytesReadTotal += bytesRead
                print(bytesReadTotal)
                if isFirst {
//                        vl.append(contentsOf: buffer[0..<2])
//                        fh.append(contentsOf: buffer[4..<6])
                    vl = UInt16(buffer[0]) << 8 | UInt16(buffer[1])
                    fh = UInt16(buffer[4]) << 8 | UInt16(buffer[5])
//                        print(vlData)
//                        print(fhData)
                    headerData.append(contentsOf: buffer[8..<62])
                    bmp.append(contentsOf: buffer[62..<bytesRead])
                    isFirst = false
                } else {
//                        vlData.append(contentsOf: buffer[0..<2])
//                        fhData.append(contentsOf: buffer[4..<6])
                    bmp.append(contentsOf: buffer[0..<bytesRead])
                }
                        
                if isFirst == false && bytesReadTotal == 49214{
                            // The first image has been fully received
                            // Check if header is valid BMP header
                    if headerData.count == 54 && headerData[0] == 0x42 && headerData[1] == 0x4D {
                        print(headerData.count)
  
                        self.bmpData.removeAll()
                        self.vlData.removeAll()
                        self.fhData.removeAll()
                        self.bmpData = headerData + bmp[0...] // Remove header from data
//                            self.vlData = vl[0..<2]
//                            self.fhData = fh[0..<2]
                        self.vlData = Data([UInt8(vl >> 8), UInt8(vl & 0xFF)]) // Store vl as Data
                        self.fhData = Data([UInt8(fh >> 8), UInt8(fh & 0xFF)])
//                                print(self.bmpData)
                        print(self.vlData)
                        print(self.fhData)

                        return
                    }
                }
            } else {
                print("Stream closed")
                return
            }
        }
    }
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

