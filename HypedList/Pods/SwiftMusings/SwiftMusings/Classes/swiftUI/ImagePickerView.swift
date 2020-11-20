//
// Created by Lei Zhao on 10/30/20.
//

import SwiftUI
import MobileCoreServices
import SwiftMusings

public struct ImagePickerView: UIViewControllerRepresentable {

    var sourceType: UIImagePickerController.SourceType
    var mediaTypes: [String]
    var onPickImage: ((_ image: UIImage) -> Void)?
    var onPickVideo: ((_ url: URL) -> Void)?
    var onCancelPick: (() -> Void)?
    var onError: ((_ error: Error) -> Void)?

    public init(
      sourceType: UIImagePickerController.SourceType = .photoLibrary,
      mediaTypes: [String] = [String(kUTTypeImage), String(kUTTypeMovie)],
      onPickImage: ((UIImage) -> ())?,
      onPickVideo: ((URL) -> ())?,
      onCancelPick: (() -> ())?,
      onError: ((Error) -> Void)?) {
        self.sourceType = sourceType
        self.mediaTypes = mediaTypes
        self.onPickImage = onPickImage
        self.onPickVideo = onPickVideo
        self.onCancelPick = onCancelPick
        self.onError = onError
    }

    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()

        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            onCancelPick?()
            onError?(CustomError("sourceType \(sourceType) is not Available"))
        }

        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = mediaTypes
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let mediaType = info[.mediaType] as? String else {
                return
            }

            if mediaType == String(kUTTypeImage) {
                guard let uiImage = info[.originalImage] as? UIImage else {
                    return
                }
                parent.onPickImage?(uiImage)
            }

            if mediaType == String(kUTTypeMovie) {
                guard let mediaUrl = info[.mediaURL] as? URL else {
                    return
                }
                parent.onPickVideo?(mediaUrl)
            }
        }

        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onCancelPick?()
        }
    }
}
