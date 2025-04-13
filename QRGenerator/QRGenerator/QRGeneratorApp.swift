//
//  QRGeneratorApp.swift
//  QRGenerator
//

import SwiftUI
import SwiftData

@main
struct QRGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreen()                
        }
        .modelContainer(for: [ModelQR.StoredQRCode.self])
    }
    
}
