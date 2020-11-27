//
// Created by Lei Zhao on 11/26/20.
//

import Foundation
import Vision
import UIKit

@available(macCatalyst 13.0, *)
public class CodeClassifier {

    public init() {
    }

    public func extractCode(
      _ image: UIImage,
      onComplete: ((_ result: [VNBarcodeObservation], _ error: Error?) -> Void)?
    ) {
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue)),
              let cgImage = image.cgImage else {
            onComplete?([], nil)
            return
        }

        let request = VNDetectBarcodesRequest { request, error in
            if error != nil {
                onComplete?([], error)
                return
            }

            guard let observations = request.results as? [VNBarcodeObservation] else {
                onComplete?([], CustomError("Cannot convert result to [VNBarcodeObservation]"))
                return
            }
            onComplete?(observations, nil)
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: orientation)
        do {
            try handler.perform([request])
        } catch {
            onComplete?([], error)
        }
    }
}
