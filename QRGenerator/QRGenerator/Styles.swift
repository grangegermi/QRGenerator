//
//  Styles.swift
//  QRGenerator
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(10.0)
    }
}

enum Images: String {
    case chevron = "chevron.left"
    case share = "square.and.arrow.up"
    case error = "exclamationmark.triangle.fill"
}

extension Image {
    init(_ systemName: Images) {
        self.init(systemName: systemName.rawValue)
    }
}

