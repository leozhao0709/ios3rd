//
//  ContentView.swift
//  ImageClassification
//
//  Created by Lei Zhao on 11/24/20.
//
//

import SwiftUI
import SwiftMusings

struct ContentView: View {

    @State var showCamera = false
    @State var uiImage: UIImage?

    private func analyze(image: UIImage) {
        guard let resizedImage = image.resize(CGSize(width: 224, height: 224))
          let buffer = resizedImage
          else {

        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if let image = uiImage {
                    Image(uiImage: image)
                }
            }
                .navigationBarItems(trailing: Button("Scan") {
                    self.showCamera.toggle()
                })
                .sheet(isPresented: $showCamera) {
                    ImagePickerView(sourceType: .camera, onPickImage: { image in
                        self.uiImage = image
                    }, onPickVideo: nil, onCancelPick: {
                        self.showCamera.toggle()
                    }, onError: { error in
                        printLog(error.localizedDescription)
                        self.showCamera.toggle()
                    })
                }
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
