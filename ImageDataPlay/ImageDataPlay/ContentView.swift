//
//  ContentView.swift
//  ImageDataPlay
//
//  Created by Lei Zhao on 11/15/20.
//
//

import SwiftUI

struct ContentView: View {

    let image = UIImage(named: "test") ?? UIImage()

    var body: some View {
        ScrollView {
            Image(uiImage: image)
              .resizable()
              .frame(width: 300)
              .padding()
            Button("calculate") {
                print(image.getPixels()?.count)
            }
            Image(uiImage: self.generateGrayImage(image: image))
              .resizable()
              .frame(width: 300)
              .padding()
//                .background(Color.red)
        }
    }

    func generateGrayImage(image: UIImage) -> UIImage {
        let imageData = image.getPixels()
        var newImageData: [UInt8] = [UInt8](repeating: 0, count: imageData?.count ?? 0)
        for i in stride(from: 0, to: (imageData?.count ?? 0), by: 4){
            let grey: UInt8 = UInt8(Double(imageData![i]) * 0.299 + Double(imageData![i+1]) * 0.587 + Double(imageData![i+2]) * 0.114)
            newImageData[i] = grey
            newImageData[i + 1] = grey
            newImageData[i + 2] = grey
            newImageData[i + 3] = imageData![i + 3]
        }
        return UIImage(pixels: newImageData, width: image.size.width) ?? UIImage()
    }
}
