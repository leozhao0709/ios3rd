//
// Created by Lei Zhao on 11/26/20.
//

import Foundation
import Vision
import UIKit
import CoreML

@available(macCatalyst 13.0, *)
public class TextClassifier {
    public init() {
    }

    public func detect(
      _ image: UIImage,
      color: UIColor = .red,
      lineWidth: CGFloat = 5.0,
      onComplete: ((_ img: UIImage?, _ result: [VNRecognizedTextObservation], _ error: Error?) -> Void)?) {

        guard let cgImage = image.cgImage,
              let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
          else {
            onComplete?(nil, [], CustomError("Cannot convert image to cgimage and get it orientation"))
            return
        }

        let request = VNRecognizeTextRequest { request, error in
            if let error = error {
                onComplete?(nil, [], error)
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                onComplete?(nil, [], CustomError("Cannot convert result to [VNRecognizedTextObservation]"))
                return
            }

            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    onComplete?(
                      image.addVNDetectedObjectObservation(
                        observations: observations,
                        color: color,
                        lineWidth: lineWidth
                      ),
                      observations,
                      nil
                    )
                }
            }
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)
        do {
            try handler.perform([request])
        } catch {
            onComplete?(nil, [], error)
        }

    }
}
