//
// Created by Lei Zhao on 10/30/20.
//

import SwiftUI
import MobileCoreServices

struct ImagePickerView: UIViewControllerRepresentable {

    var onPickImage: ((_ image: UIImage) -> Void)?
    var onPickVideo: ((_ url: URL) -> Void)?
    var onCancelPick: (() -> Void)?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePickerController.sourceType = .camera
//        } else {
            imagePickerController.sourceType = .photoLibrary
//        }

        imagePickerController.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let mediaType = info[.mediaType] as? String else {
                return
            }

            if mediaType == String(kUTTypeImage) {
                guard let uiImage = info[.originalImage] as? UIImage else{
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

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.onCancelPick?()
        }
    }
}
