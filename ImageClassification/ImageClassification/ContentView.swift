//
//  ContentView.swift
//  ImageClassification
//
//  Created by Lei Zhao on 11/24/20.
//
//

import SwiftUI
import SwiftMusings
import CoreML

struct ContentView: View {

    @State var showSheet = false
    @State var uiImage: UIImage?
    @State var predicatedText: String?
    @State var showActionSheet = false
    @State var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack {
            if let image = uiImage {
                Image(uiImage: image)
                  .resizable()
                  .scaledToFit()
//                  .frame(maxHeight: 200)
            }

            if let predicatedText = predicatedText {
                Text(predicatedText)
                  .multilineTextAlignment(.center)
            }

            Button("select or take photo") {
                self.showActionSheet.toggle()
            }
        }
          .actionSheet(isPresented: $showActionSheet) {
              ActionSheet(title: Text("Select A PhotoSource"), buttons: [
                  .default(Text("Select from photo")) {
                      self.imagePickerSourceType = .photoLibrary
                      self.showSheet.toggle()
                  },
                  .default(Text("Take a photo")) {
                      self.imagePickerSourceType = .camera
                      self.showSheet.toggle()
                  }
              ])
          }
          .sheet(isPresented: $showSheet) {
              ImagePickerView(sourceType: self.imagePickerSourceType, onPickImage: { image in
//                  self.uiImage = image
                  self.showSheet.toggle()


//                  guard let imageVisionClassifier = try? ImageVisionClassifier(mlModel: CatDogMLTrain_1(
//                    configuration: MLModelConfiguration()).model) else {
//                      return
//                  }
//
//                  imageVisionClassifier.classify(image, onComplete: { observations in
//                      self.predicatedText = observations.map {
//                          "\($0.identifier): \($0.confidence)"
//                      }.joined(separator: "\n")
//                  }, onError: { error in
//                      printLog(error.localizedDescription)
//                  })

              let faceVisionClassifier = FaceVisionClassifier()
                faceVisionClassifier.detectFaces(image: image, onComplete: { img, observations in
                    self.uiImage = img
                    print("\(observations.count)")
                }, onError: nil)

              }, onPickVideo: nil, onCancelPick: {
                  self.showSheet.toggle()
              }, onError: { error in
                  printLog(error.localizedDescription)
                  self.showSheet.toggle()
              })
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
