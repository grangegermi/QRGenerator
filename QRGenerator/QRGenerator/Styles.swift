//
//  Styles.swift
//  QRGenerator
//
//  Created by Даша Волошина on 13.04.25.
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

