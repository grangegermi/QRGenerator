//
//  QRGenerator.swift
//  QRGenerator
//

import UIKit
import CoreImage.CIFilterBuiltins

protocol QRGenerator {
    func generateQRCode(from string: String, size: CGFloat) throws -> UIImage
    func generateQRCode(from stored: ModelQR.StoredQRCode, size: CGFloat) throws -> ModelQR.QRCode
    func generateWiFiQR(ssid: String, password: String, security: String, size: CGFloat) throws -> ModelQR.QRCode
    func generateInstagramQR(username: String, size: CGFloat) throws -> ModelQR.QRCode
    func generateLinkQR(link: URL, size: CGFloat) throws -> ModelQR.QRCode
}

class Generator: QRGenerator {
    
    func generateQRCode(from string: String, size: CGFloat) throws -> UIImage {
        guard let data = string.data(using: .utf8) else {
            throw AppError.noInputData
        }
        let filter = CIFilter.qrCodeGenerator()
        filter.message = data
        
        if let outputImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: size, y: size)) {
            let contextOptions = [CIContextOption.useSoftwareRenderer: true]
            let context = CIContext(options: contextOptions)
            
            guard let image = context.createCGImage(outputImage, from: outputImage.extent) else {
                throw AppError.generatingQRCodeFailed
            }
            return UIImage(cgImage: image)
        } else {
            throw AppError.generatingQRCodeFailed
        }
    }
    
    func generateWiFiQR(ssid: String, password: String, security: String, size: CGFloat) throws -> ModelQR.QRCode {
        guard !ssid.isEmpty || !security.isEmpty || !password.isEmpty else {
            throw AppError.noInputData
        }
        
        let value = "WIFI:T:\(security);S:\(ssid);P:\(password);;"
        let image = try generateQRCode(from: value, size: size)
        return ModelQR.QRCode(name: "WiFi: \(ssid)", image: image, content: value)
    }
    
    func generateQRCode(from stored: ModelQR.StoredQRCode, size: CGFloat) throws -> ModelQR.QRCode {
            let image = try generateQRCode(from: stored.content, size: size)
            return ModelQR.QRCode(name: stored.name, image: image, content: stored.content)
        }
    
    func generateInstagramQR(username: String, size: CGFloat) throws -> ModelQR.QRCode {
            let value = "instagram://user?username=\(username)"
            let image = try generateQRCode(from: value, size: size)
            return ModelQR.QRCode(name: "Instagram: \(username)", image: image, content: value)
        }

        func generateLinkQR(link: URL, size: CGFloat) throws -> ModelQR.QRCode {
            let image = try generateQRCode(from: link.absoluteString, size: size)
            return ModelQR.QRCode(name: "Link: \(link)", image: image, content: link.absoluteString)
        }
}
