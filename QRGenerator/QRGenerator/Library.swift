//
//  Library.swift
//  QRGenerator
//
//  Created by Даша Волошина on 13.04.25.
//

import SwiftUI
import SwiftData

struct Library: View {
    @Environment(\.qrGenerator) var qrGenerator
    @Environment(\.dataManager) var modelManager
    @Environment(\.modelContext) var context

    @Query private var qrCodes: [ModelQR.StoredQRCode]
    @State private var selectedQRCode: ModelQR.QRCode?

    var body: some View {
        VStack {
            List(qrCodes) { qrCode in
                Button(action: {
                    generateQR(from: qrCode )
                }) {
                    HStack {
                        Text(qrCode.name)
                        Spacer()
                        Image(.chevron)
                    }
                }
                .swipeActions {
                    Button("Delete", role: .destructive) {
                        do {
                            try  modelManager.delete(context: context, qr: qrCode)
                        } catch {
                            DataBaseError.deleteFailed
                        }
                    }
                }
            }
                .sheet(item: $selectedQRCode) { _ in
                    QrCodeView(item: $selectedQRCode)
                        .presentationDetents([.medium])
                }
            Spacer()
            Divider()
                .background(Color.accentColor)
        }
        .padding()
        .background(Color.appBackground)
    }
}



extension Library {
    func generateQR(from qr: ModelQR.StoredQRCode) {
        
        do {
            selectedQRCode  = try qrGenerator.generateQRCode(from: qr, size: 10)
        } catch {
            
        }
    }
}

#Preview {
    Library()
}
