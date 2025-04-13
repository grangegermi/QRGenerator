//
//  QrCodeView.swift
//  QRGenerator
//

import SwiftUI

struct QrCodeView: View {
    let qrImage: UIImage

    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: qrImage)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding()

            HStack {
//                ShareLink(item: qrImage) {
//                    Image(.resultShare)
//                }

                Button("Share") {
                    let activityVC = UIActivityViewController(activityItems: [qrImage], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Save") {
                    UIImageWriteToSavedPhotosAlbum(qrImage, nil, nil, nil)
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Print") {
                    let printInfo = UIPrintInfo(dictionary: nil)
                    printInfo.outputType = .photo
                    let printController = UIPrintInteractionController.shared
                    printController.printInfo = printInfo
                    printController.printingItem = qrImage
                    printController.present(animated: true)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}
