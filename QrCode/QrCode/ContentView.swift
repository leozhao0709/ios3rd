//
//  ContentView.swift
//  QrCode
//
//  Created by Lei Zhao on 11/1/20.
//
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {

    @State(initialValue: "") private var name
    @State(initialValue: "") private var phone

    var body: some View {
        NavigationView {
            VStack {
                TextField("name", text: $name)
                  .font(.title)
                  .padding(.horizontal)
                TextField("phone", text: $phone)
                  .font(.title)
                  .keyboardType(.numberPad)
                  .padding([.horizontal, .bottom])
                Image(uiImage: generateQRCode(code: "\(name) \n \(phone)") ?? UIImage())
                  .interpolation(.none)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 200)
                Spacer()
            }
              .navigationBarTitle("My QRcode")
        }
    }

    func generateQRCode(code: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()

        let data = code.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        let outputImage = filter.outputImage

        guard let ciImage = outputImage,
              let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
          else {
            return UIImage()
        }

        return UIImage(cgImage: cgImage)
    }

    func getQRCode(qrCodeImage: UIImage?) -> [String]? {
        guard let qrCodeImage = qrCodeImage else {
            return nil
        }

        //1. 创建过滤器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)

        //2. 获取CIImage
        guard let ciImage = CIImage(image: qrCodeImage) else { return nil }

        //3. 识别二维码
        guard let features = detector?.features(in: ciImage) else { return nil }

        //4. 遍历数组, 获取信息
        return features.compactMap { feature in
            (feature as? CIQRCodeFeature)?.messageString
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: ContentView_Previews.previews)
        }
    #endif
}
