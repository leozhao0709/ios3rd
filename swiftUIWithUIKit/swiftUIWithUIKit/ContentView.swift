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
import SwiftMusings
import MobileCoreServices

struct ContentView: View {

    @State(initialValue: false) private var showSheet
    @State private var image: UIImage?
    @State private var videoUrl: URL? {
        didSet {
            self.player = AVPlayer(url: self.videoUrl!)
        }
    }
    @State private var player: AVPlayer?
    @State private var showAlert: Bool = false

    let permissionManager = PermissionManager.sharedInstance
    let imagePickSourceType: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        NavigationView {
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                      .resizable()
                      .scaledToFit()
                }

                if let player = self.player {
                    AVPlayerView(player: player, showsPlaybackControls: true)
                      .frame(width: 300, height: 400)
                }
                Button("select photos or video") {
                    if imagePickSourceType == .camera {
                        permissionManager.checkCameraPermission(onGranted: {
                            printLog("....granted....")
                            self.showSheet.toggle()
                        }) { status in
                            printLog("....Not granted....\(status.rawValue)")
                            self.showSheet.toggle()
                        }
                    } else {
                        self.showSheet.toggle()
                    }
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
              .alert(isPresented: $showAlert) {
                  Alert(
                    title: Text("Need Camera Access"),
                    message: Text("Camera access is required to make full use of this app."),
                    primaryButton: .default(Text("allow camera")) {
                        permissionManager.openSettings { b in printLog("...openSettings...\(b)") }
                    },
                    secondaryButton: .default(Text("Cancel")){}
                  )
              }
              .sheet(isPresented: $showSheet) {
                  ImagePickerView(
                    sourceType: imagePickSourceType,
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
                  ) { error in
                      printLog("...error...\(error.localizedDescription)")
                  }
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
