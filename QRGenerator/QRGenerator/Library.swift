//
//  Library.swift
//  QRGenerator
//
//  Created by Даша Волошина on 13.04.25.
//

import SwiftUI

struct Library: View {
    @Environment(\.qrGenerator) var qrGenerator

    @State private var qrCodes = [ModelQR.StoredQRCode]()
    @State private var selectedQRCode: ModelQR.QRCode?

    var body: some View {
        NavigationView {
            List(qrCodes) { qrCode in
                Button(action: {
                    
                }) {
                    HStack {
                        Text(qrCode.name)
                    }
                }
            }
            .sheet(item: $selectedQRCode) { qrCode in
                QrCodeView(item: $selectedQRCode)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    Library()
}
