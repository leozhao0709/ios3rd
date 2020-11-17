//
// Created by Lei Zhao on 11/16/20.
//

import UIKit
import CoreImage.CIFilterBuiltins

extension UIImage {

    public func applyFilter(filter: CIFilter?, size: CGSize = CGSize(width: 280, height: 280)) -> UIImage? {

        guard let filter = filter else {
            return nil
        }


        guard filter.inputKeys.contains(kCIInputImageKey) else{
            return nil
        }

        guard let inputImage = CIImage(image: self) else {
            return nil
        }

        // apply filter
        filter.setValue(inputImage, forKey: kCIInputImageKey)

        let context = CIContext()
        let outputImage = filter.outputImage
//        guard let ciImage = outputImage?.resizeCIImage(size: size),
        guard let ciImage = outputImage,
              let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
          else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
