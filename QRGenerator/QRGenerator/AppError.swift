//
//  AppError.swift
//  QRGenerator
//

import Foundation

enum AppError: Error {
    case noInputData
    case generatingQRCodeFailed
    case noConnection
}
