//
//  Services.swift
//  QRGenerator
//

import SwiftUI

enum Services {
    static let qrGenerator = Generator()
    static let modelManager = ModelManager()
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
    
    struct  EnvironmentValueData: EnvironmentKey {
        static let defaultValue: DataBaseManager = Services.modelManager
    }
    
    var dataManager: DataBaseManager {
         get {
             self[EnvironmentValueData.self]
         }
     }
    
}
