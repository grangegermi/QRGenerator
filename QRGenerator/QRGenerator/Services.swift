//
//  Services.swift
//  QRGenerator
//

import SwiftUI

enum Services {
    static let qrGenerator = Generator()
}

struct EnvironmentValueGenerator: EnvironmentKey {
    static let defaultValue: QRGenerator = Services.qrGenerator
}


extension EnvironmentValues {
    var qrGenerator: QRGenerator {
        get {
            self[EnvironmentValueGenerator.self]
        }
    }
}
