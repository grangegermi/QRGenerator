//
//  GeneratorScreen.swift
//  QRGenerator
//

import SwiftUI
import SwiftData

enum GeneratorType: CaseIterable {
    case link
    case wifi
    case instagram
    
    var title: String {
        switch self {
        case .link:
            return "Link"
        case .wifi:
            return "WiFi"
        case .instagram:
            return "Instagram"
        }
    }
}

struct GeneratorScreen: View {
    @Environment(\.qrGenerator) var qrGenerator
    @Environment(\.dataManager) var modelManager
    @Environment(\.modelContext) var context
    
    
    @State private var type = GeneratorType.link
    @State private var value1: String = ""
    @State private var value2: String = ""
    @State private var qrCode: ModelQR.QRCode?
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("", selection: $type) {
                ForEach(GeneratorType.allCases, id: \.self) { item in
                    Text(item.title)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            switch type {
            case .link:
                TextField("Enter URL", text: $value1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            case .wifi:
                TextField("Enter SSID", text: $value1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Enter Password", text: $value2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            case .instagram:
                TextField("Your username", text: $value1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            Spacer()
            
            Button("Generate QR Code") {
                generateQRCode()                
                do {
                    guard let qr = qrCode else {return}
                    do {
                        try  modelManager.add(context: context, from: qr)
                    }
                } catch {
                    DataBaseError.saveFailed
                }
            }
            .modifier(ButtonStyle())
            .padding()
        }
        .padding()
        .sheet(item: $qrCode) { _ in
            QrCodeView(item: $qrCode)
                .presentationDetents([.medium])
        }
    }
}

extension GeneratorScreen {
    private func generateQRCode() {
        do {
            switch type {
            case .link:
                guard let link = URL(string: value1) else {
                    throw AppError.invalidURL
                }
                qrCode = try qrGenerator.generateLinkQR(link: link, size: 10)
            case .wifi:
                qrCode = try qrGenerator.generateWiFiQR(ssid: value1, password: value2, security: "WPA", size: 10)
            case .instagram:
                qrCode = try qrGenerator.generateInstagramQR(username: value1, size: 10)
            }
        } catch {
            AppError.noInputData
        }
    }
}


#Preview {
    GeneratorScreen()
}
