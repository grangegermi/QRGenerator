//
//  AppError.swift
//  QRGenerator
//

import Foundation

enum AppError: Error {
    case noInputData
    case invalidURL
    case generatingQRCodeFailed
    case noConnection
}

enum DataBaseError: Error {
    case saveFailed
    case deleteFailed
}
