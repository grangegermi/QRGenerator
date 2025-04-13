//
//  Model.swift
//  QRGenerator
//

import Foundation
import SwiftData

enum ModelQR {
    @Model
    class QRCode {
        @Attribute(.unique) var id: UUID
        var name: String
        var imagePath: URL

        init(name: String, imagePath: URL) {
            self.id =  UUID()
            self.name = name
            self.imagePath = imagePath
        }
    }
}

enum WiFiSecurity: String {
    case WEP = "WEP"
    case WPA = "WPA"
    case WPA2 = "WPA2"
    case none = "nopass"
}
