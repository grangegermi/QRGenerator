//
//  QrCodeView.swift
//  QRGenerator
//

import SwiftUI

struct Photo: Identifiable, Transferable {
    let id = UUID()
    let image: Image
    let caption: String

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}

struct QrCodeView: View {
    @Binding var item: ModelQR.QRCode?
    
    var body: some View {
        VStack(spacing: .zero) {
            if let item {
                Text(item.name)
                    .font(.title)
                    .padding()
                
                Image(uiImage: item.image)
                    .resizable()
                    .scaledToFit()
                
                let photo = Photo(image: Image(uiImage: item.image), caption: item.name)
                ShareLink(item: photo, preview: SharePreview(photo.caption, image: photo.image)) {
                    Label("Share QR Code", systemImage: "square.and.arrow.up")
                        .modifier(ButtonStyle())
                        .padding()
                }
            } else {
                Text("not working")
            }
        }
    }
}
