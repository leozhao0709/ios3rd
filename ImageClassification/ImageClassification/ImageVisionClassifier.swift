//
// Created by Lei Zhao on 11/24/20.
//

import Foundation
import CoreML
import Vision
import UIKit
import SwiftMusings

class ImageVisionClassifier {
    private let model: VNCoreMLModel

    init?(mlModel: MLModel) {
        guard let model = try? VNCoreMLModel(for: mlModel) else {
            return nil
        }
        self.model = model
    }

    func classify(
      _ image: UIImage,
      onComplete: ((_ result: [VNClassificationObservation]) -> Void)? = nil,
      onError: ((Error) -> Void)?
    ) {
        DispatchQueue.global().async {
            guard let cgImage = image.cgImage else {
                onError?(CustomError("Cannot convert image to cgImage"))
                return
            }

            let handler = VNImageRequestHandler(cgImage: cgImage)

            do {
                let request = VNCoreMLRequest(model: self.model) { (request, error) in
                    guard let results = request.results as? [VNClassificationObservation] else {
                        onError?(CustomError("Cannot convert results to [VNClassificationObservation] "))
                        return
                    }
                    onComplete?(results)
                }
                request.imageCropAndScaleOption = .centerCrop

                try handler.perform([request])
            } catch {
                onError?(error)
            }
        }
    }
}
