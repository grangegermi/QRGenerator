//
//  Model.swift
//  QRGenerator
//

import Foundation
import SwiftData
import UIKit

enum ModelQR {
    struct QRCode: Identifiable {
            let id: UUID
            let name: String
            let image: UIImage
            let content: String

            init(name: String, image: UIImage, content: String) {
                self.id =  UUID()
                self.name = name
                self.image = image
                self.content = content
            }
        }
        
    @Model
    class StoredQRCode: Identifiable {
        @Attribute(.unique) var id: UUID
        var name: String
        var content: String

        init(name: String, content: String) {
            self.id =  UUID()
            self.name = name
            self.content = content
        }
    }
}

enum WiFiSecurity: String {
    case WEP
    case WPA
    case WPA2
}
