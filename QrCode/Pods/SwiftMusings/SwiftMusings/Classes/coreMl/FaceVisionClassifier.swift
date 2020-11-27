//
// Created by Lei Zhao on 11/25/20.
//

import Foundation
import CoreML
import Vision
import UIKit

@available(macCatalyst 13.0, *)
public class FaceVisionClassifier {

    public init() {
    }

    public func detectFaces(
      image: UIImage,
      color: UIColor = .red,
      lineWidth: CGFloat = 5.0,
      // image that drawing the face
      // observations is request result
      onComplete: ((_ img: UIImage?, _ observations: [VNFaceObservation], _ error: Error?) -> Void)?) {
        guard let cgImage = image.cgImage,
              let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
          else {
            onComplete?(nil, [], CustomError("Cannot convert image to cgimage and get it orientation"))
            return
        }

        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)

        DispatchQueue.global().async {
            guard let _ = try? handler.perform([request]),
                  let observations = request.results as? [VNFaceObservation] else {
                onComplete?(nil, [], CustomError("Cannot get face observation"))
                return
            }

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
}
