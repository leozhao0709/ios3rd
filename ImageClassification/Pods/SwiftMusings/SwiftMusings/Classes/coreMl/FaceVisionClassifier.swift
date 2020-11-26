//
// Created by Lei Zhao on 11/25/20.
//

import Foundation
import CoreML
import Vision
import UIKit

@available(macCatalyst 13.0, *)
public class FaceVisionClassifier {

    public init() {}

    public func detectFaces(
      image: UIImage,
      // image that drawing the face
      // observations is request result
      onComplete: ((_ img: UIImage?, _ observations: [VNFaceObservation]) -> Void)? = nil,
      onError: ((Error) -> Void)?) {
        guard let cgImage = image.cgImage,
              let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
          else {
            onError?(CustomError("Cannot convert image to cgimage and get it orientation"))
            return
        }

        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)

        DispatchQueue.global().async {
            guard let _ = try? handler.perform([request]),
                  let observations = request.results as? [VNFaceObservation] else {
                onError?(CustomError("Cannot get face observation"))
                return
            }

            DispatchQueue.main.async {
                onComplete?(image.addVNFaceObservation(observations: observations), observations)
            }
        }
    }
}
