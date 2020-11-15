//
//  ContentView.swift
//  ImagePlay
//
//  Created by Lei Zhao on 11/13/20.
//
//

import SwiftUI
import SDWebImageSwiftUI
import UIKit
import SwiftMusings

struct ContentView: View {

    @State var uiImage: UIImage?
    @State var rotateAngle: Angle = .zero
    @State var lastImageAngle: Angle = .zero

    var rotation: some Gesture {
        RotationGesture()
          .onChanged { angle in
              printLog(message: "rotate....")
              self.rotateAngle = angle + lastImageAngle
          }
          .onEnded { angle in
              self.lastImageAngle = angle + lastImageAngle
          }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 100) {
                WebImage(url: URL(string: "https://s3.amazonaws.com/images.seroundtable.com/google-css-images-1515761601.jpg"))
                  .onSuccess { (image: PlatformImage, data: Data?, v: SDImageCacheType) in
                      guard let data = data else {
                          return
                      }
                      uiImage = UIImage(data: data)
                  }
                  .resizable()
                  .frame(width: 300, height: 200)

                if let uiImage = self.uiImage {
                    Image(uiImage: uiImage)
                      .resizable()
                      .frame(width: 300, height: 200)
                      .rotationEffect(rotateAngle)
                      .gesture(rotation)

                    Image(uiImage: uiImage.resize(CGSize(width: 300, height: 200))!.rotate(by: self.rotateAngle) ?? uiImage)
                      .resizable()
                      .frame(width: 300, height: 200)

                    Image(uiImage: uiImage.crop(CGRect(x: 50, y: 50, width: 100, height: 100)))
                      .resizable()
                      .frame(width: 300, height: 200)

                    Image(uiImage: uiImage.circleImage()!)
//                      .resizable()
//                      .frame(width: 300, height: 200)

                }
            }
        }
    }
}
