//
//  ModelMannager.swift
//  QRGenerator
//

import Foundation
import SwiftData
import SwiftUI

protocol DataBaseManager {

    func add(context: ModelContext, from qr: ModelQR.QRCode) throws -> ModelQR.StoredQRCode
    func delete(context: ModelContext, qr: ModelQR.StoredQRCode) throws
}

class ModelManager: DataBaseManager {

    func add(context: ModelContext, from qr: ModelQR.QRCode) throws -> ModelQR.StoredQRCode {

        var item  =  ModelQR.StoredQRCode(id: qr.id, name: qr.name, content: qr.content)
        context.insert(item)

        return item
    }

    func delete(context: ModelContext, qr: ModelQR.StoredQRCode) throws {
        context.delete(qr)
    }
}
