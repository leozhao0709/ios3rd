//
//  ContentView.swift
//  swiftUIWithUIKit
//
//  Created by Lei Zhao on 10/30/20.
//
//

import SwiftUI
import Photos
import AVKit

struct ContentView: View {

    @State(initialValue: false) private var showSheet
    @State private var image: UIImage?
    @State private var videoUrl: URL?
    private var player: AVPlayer? {
        if let url = self.videoUrl {
            return AVPlayer(url: url)
        }
        return nil
    }

    var body: some View {
         NavigationView {
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                      .resizable()
                      .scaledToFit()
                }
                if let url = self.videoUrl {
//                    VideoPlayer(player: self.player)
//                    {
//                        VStack {
//                            Text("Watermark")
//                                .font(.caption)
//                                .foregroundColor(.white)
//                                .background(Color.black.opacity(0.7))
//                              .clipShape(Capsule())
//                            Spacer()
//                        }
//                    }
//                        .frame(width: 300, height: 400)

                AVPlayerView(mediaUrl: url)
                }
                Button("select photos or video") {
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
                      })
                  }
              })
              .sheet(isPresented: $showSheet) {
                  ImagePickerView(
                    onPickImage: {
                        image in
                        self.image = image
                        self.showSheet.toggle()
                    },
                    onPickVideo: { url in
                        self.videoUrl = url
                        self.showSheet.toggle()
                    },
                    onCancelPick: { self.showSheet.toggle() }
                  )
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
