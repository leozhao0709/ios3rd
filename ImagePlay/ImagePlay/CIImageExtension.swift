//
// Created by Lei Zhao on 11/14/20.
//

import UIKit

extension CIImage {

    /// resize CIImage
    ///
    /// - parameter size: desired CIImage size
    ///
    /// - returns: resized CIImage
    func resizeCIImage(size: CGSize)->CIImage {
        let extent = self.extent.integral
        let scale = min(size.width/extent.width, size.height/extent.height)

        let width = extent.width * scale
        let height = extent.height * scale
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(self, from: extent)
        bitmapRef!.interpolationQuality = .none
        bitmapRef!.scaleBy(x: scale, y: scale)
        bitmapRef?.draw(bitmapImage!, in: extent)

        let scaledImage = bitmapRef!.makeImage()
        return CIImage(cgImage: scaledImage!)
    }
}
