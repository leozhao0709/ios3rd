//
// Created by Lei Zhao on 11/15/20.
//

import UIKit

extension UIImage {

    // return [r, g, b, a]: range [0-255, 0-255, 0-255, 0 - 1]
    public func getPixel(atRelativePoint point: CGPoint) -> [UInt8]? {
        guard point.x < size.width && point.y < size.height else {
            print("point(\(point.x), \(point.y) is not in image(\(self.size.width), \(self.size.height)")
            return nil
        }

        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return nil
        }

        let componentsPerPixel: CGFloat = 4; // 4 pixels each
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = Int((size.width * point.y + point.x) * componentsPerPixel * scale * scale)

        return [data[pixelInfo], data[pixelInfo + 1], data[pixelInfo + 2], data[pixelInfo + 3]]
    }

    // // [r, g, b, a, r, g, b, a...] for each pixels
    public func getPixels() -> [UInt8]? {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return nil
        }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let componentsPerPixel: CGFloat = 4 // 4 pixels each
        let buffer = UnsafeBufferPointer(start: data, count: Int(size.width * size.height * componentsPerPixel * scale * scale));
        return Array(buffer)
    }

    public convenience init?(pixels: [UInt8], width: CGFloat) {
        let componentsPerPixel: CGFloat = 4 // 4 pixels each
        let bitsPerComponent: CGFloat = 8
        let bytesPerRow = width * 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        let height: CGFloat = CGFloat(pixels.count) / componentsPerPixel / width

        var pixelsCopy = Array(pixels)
        let data = UnsafeMutablePointer(mutating: &pixelsCopy)

        guard let bmContext = CGContext(
          data: data,
          width: Int(width),
          height: Int(height),
          bitsPerComponent: Int(bitsPerComponent),
          bytesPerRow: Int(bytesPerRow),
          space: colorSpace,
          bitmapInfo: CGBitmapInfo(rawValue: 0).rawValue | alphaInfo.rawValue
        ) else {
            return nil
        }

        // create the image:
        guard let cgImageRef = bmContext.makeImage() else {
            return nil
        }
        self.init(cgImage: cgImageRef)
    }
}
