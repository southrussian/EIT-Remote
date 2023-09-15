import SwiftUI
import Foundation


struct VentilationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var bmpData: Data = Data()
    @State private var vlData: Data = Data()
    @State private var fhData: Data = Data()
    @State private var ipAddress: String = ""
    @State private var portNumber: String = ""
    @State private var showAlert: Bool = false
    @State private var isReceiving = false
    @State private var timer: Timer?
    @State private var generatedPDFURL: URL?
    @State var showShareLink: Bool = false
    @State var generatedImage: Image?
    
    @State var viewModel: VentilationViewModel

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ScrollView {
                VStack {
                    HStack {
                        Text("Вентиляция: \(viewModel.patient.name) \(viewModel.patient.surname)")
                            .font(.title)
                            .bold()
                        Spacer()
                    
                    }
                    .offset(y: -30)
                    .padding(.horizontal)
                    HStack {
                        Text("IP-адрес:")
                            .foregroundColor(.mint)
                        Spacer()
                        Text(viewModel.patient.ipAddress)

                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Порт:")
                            .foregroundColor(.mint)
                        Spacer()
                        Text(viewModel.patient.port)
                    }
                    .padding(.horizontal)
                    HStack {
                        Text("Время:")
                            .foregroundColor(.mint)
                        Spacer()
                        Time()
                    }
                    .padding(.horizontal)
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
                    }
                    .padding(15)
                
                    if vlData.count >= 2, fhData.count >= 2 {
                        let vlValue = vlData.withUnsafeBytes { $0.load(as: UInt16.self) }
                        let _ = fhData.withUnsafeBytes { $0.load(as: UInt16.self) }
                        let vl = Float(vlValue) / 10.0
                        let vr = 100 - vl
                        HStack {
                            Text("VL (%): \(vl.clean)")
                                .padding(.horizontal)
                            Text("VR (%): \(vr.clean)")
                                .padding()
                        }
                    
                    } else {
                        Text("VL (%): н/д       VR (%): н/д")
                            .padding()
                    }
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    renderView(viewSize: size)
                }
            }
        }
        .sheet(isPresented: $showShareLink) {
            if let generatedPDFURL = generatedPDFURL{
                ShareSheet(items: [generatedPDFURL])

            }
        }
    }
    
    func truncateFloat(_ value: Float) -> Float {
        let truncatedValue = round(value * 10) / 10
        return truncatedValue
    }

    private func startReceiving() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
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
        guard let serverAddress = viewModel.patient.ipAddress as CFString?, let port = UInt32(viewModel.patient.port ?? "") else {
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
        var vl: UInt16 = 0
        var fh: UInt16 = 0
        var headerData = Data()
        var bytesReadTotal = 0
        var buff = [UInt8](repeating: 0, count: 4)
                
        let _ = stream.read(&buff, maxLength: buff.count)
        let _ = Int(buff[0])
        var bmp: Data = Data()
        while true {
            var buffer = [UInt8](repeating: 0, count: 49214)
                    
            let bytesRead = stream.read(&buffer, maxLength: buffer.count)
            print(buffer[0...7])
                    
            if bytesRead > 0 {
                bytesReadTotal += bytesRead
                print(bytesReadTotal)
                if isFirst {
                    vl = UInt16(buffer[0]) << 8 | UInt16(buffer[1])
                    fh = UInt16(buffer[4]) << 8 | UInt16(buffer[5])
                    headerData.append(contentsOf: buffer[8..<62])
                    bmp.append(contentsOf: buffer[62..<bytesRead])
                    isFirst = false
                } else {
                    bmp.append(contentsOf: buffer[0..<bytesRead])
                }
                        
                if isFirst == false && bytesReadTotal == 49214{
                    if headerData.count == 54 && headerData[0] == 0x42 && headerData[1] == 0x4D {
                        print(headerData.count)
  
                        self.bmpData.removeAll()
                        self.vlData.removeAll()
                        self.fhData.removeAll()
                        self.bmpData = headerData + bmp[0...] // Remove header from data
                        self.vlData = Data([UInt8(vl >> 8), UInt8(vl & 0xFF)]) // Store vl as Data
                        self.fhData = Data([UInt8(fh >> 8), UInt8(fh & 0xFF)])
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
    @MainActor
    func renderView(viewSize: CGSize) {
        let renderer = ImageRenderer(content: VentilationView(viewModel: viewModel).frame(width: viewSize.width, height: viewSize.height, alignment: .center))
        if let image = renderer.uiImage {
            generatedImage = Image(uiImage: image)
        }
        let tempUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let renderUrl = tempUrl.appendingPathComponent("\(UUID().uuidString).pdf")
        
        if let consumer = CGDataConsumer(url: renderUrl as CFURL), let context = CGContext(consumer: consumer, mediaBox: nil, nil) {
            renderer.render { size, renderer in
                var mediaBox = CGRect(origin: .zero, size: size)
                context.beginPage(mediaBox: &mediaBox)
                renderer(context)
                context.endPDFPage()
                context.closePDF()
                generatedPDFURL = renderUrl
            }
        }
    }
    
}

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

