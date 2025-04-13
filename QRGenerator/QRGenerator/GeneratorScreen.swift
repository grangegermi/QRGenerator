//
//  GeneratorScreen.swift
//  QRGenerator
//

import SwiftUI

struct GeneratorScreen: View {
    @Environment(\.qrGenerator) var qrGenerator

    @State private var ssid: String = ""
    @State private var password: String = ""
    @State private var qrImage: UIImage? = nil
    @State private var isShowingSheet: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter SSID", text: $ssid)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Enter Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Generate QR Code") {
                qrImage = try? qrGenerator.generateWiFiQR(ssid: ssid, password: password, security: "WPA", size: 10)
                isShowingSheet = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .sheet(isPresented: $isShowingSheet) {
            if let qrImage = qrImage {
                QrCodeView(qrImage: qrImage)
            }
        }
    }
}

#Preview {
    GeneratorScreen()
}
