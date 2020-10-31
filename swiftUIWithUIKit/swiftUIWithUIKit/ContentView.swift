//
//  ContentView.swift
//  swiftUIWithUIKit
//
//  Created by Lei Zhao on 10/30/20.
//
//

import SwiftUI
import Photos

struct ContentView: View {

    @State(initialValue: false) private var showSheet
    @State private var image: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                      .resizable()
                      .scaledToFit()
                }
                Button("select photos") {
                    self.showSheet.toggle()
                }
            }
              .navigationBarItems(trailing: Button("Save") {
                  if let image = self.image {
                      PHPhotoLibrary.shared().performChanges({
                          PHAssetChangeRequest.creationRequestForAsset(from: image)
                      }, completionHandler: { success, error in
                          if success {
                              print("save successfully!")
                              return
                          }

                          print("...error...", error?.localizedDescription)
                      })
                  }
              })
              .sheet(isPresented: $showSheet) {
                  ImagePickerView(onPickImage: {
                      image in
                      self.image = image
                      self.showSheet.toggle()
                  }, onCancelPickImage: { self.showSheet.toggle() })
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
