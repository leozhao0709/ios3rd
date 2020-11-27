//
// Created by Lei Zhao on 11/24/20.
//

import Foundation
import CoreML
import Vision
import UIKit

@available(macCatalyst 13.0, *)
public class ImageVisionClassifier {
    private let model: VNCoreMLModel

    public init?(mlModel: MLModel) {
        guard let model = try? VNCoreMLModel(for: mlModel) else {
            return nil
        }
        self.model = model
    }

    public func classify(
      _ image: UIImage,
      onComplete: ((_ result: [VNClassificationObservation], _ error: Error?) -> Void)?
    ) {
        DispatchQueue.global().async {
            guard let cgImage = image.cgImage else {
                onComplete?([], CustomError("Cannot convert image to cgImage"))
                return
            }

            let handler = VNImageRequestHandler(cgImage: cgImage)

            do {
                let request = VNCoreMLRequest(model: self.model) { (request, error) in
                    guard let results = request.results as? [VNClassificationObservation] else {
                        onComplete?([], CustomError("Cannot convert results to [VNClassificationObservation] "))
                        return
                    }
                    DispatchQueue.main.async {
                        onComplete?(results, nil)
                    }
                }
                request.imageCropAndScaleOption = .centerCrop

                try handler.perform([request])
            } catch {
                onComplete?([], error)
            }
        }
    }
}
