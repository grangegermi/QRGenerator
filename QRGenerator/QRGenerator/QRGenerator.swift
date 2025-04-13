//
//  QRGenerator.swift
//  QRGenerator
//

import UIKit
import CoreImage.CIFilterBuiltins

protocol QRGenerator {
    func generateQRCode(from string: String, size: CGFloat) throws -> UIImage
    func generateWiFiQR(ssid: String, password: String, security: String, size: CGFloat) throws -> UIImage
}

class Generator: QRGenerator {
    func generateQRCode(from string: String, size: CGFloat) throws -> UIImage {
        guard let data = string.data(using: .utf8) else {
            throw AppError.noInputData
        }
        let filter = CIFilter.qrCodeGenerator()
        filter.message = data

        if let outputImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: size, y: size)) {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        throw AppError.generatingQRCodeFailed
    }

    func generateWiFiQR(ssid: String, password: String, security: String, size: CGFloat = 10) throws -> UIImage {
        guard !ssid.isEmpty || !security.isEmpty || !password.isEmpty else {
            throw AppError.noInputData
        }

        let qrString = "WIFI:T:\(security);S:\(ssid);P:\(password);;"
        return try generateQRCode(from: qrString, size: size)
    }
}
