//
// Created by Lei Zhao on 11/14/20.
//

import SwiftUI
import UIKit
import Accelerate
import CoreImage.CIFilterBuiltins
import Vision

//refer: https://github.com/melvitax/AFImageHelper

public enum UIImageContentMode {
    case scaleToFill, scaleAspectFit, scaleAspectFill
}

// Convenience constructor
@available(macCatalyst 13.0, *)
extension UIImage {
    // MARK: Image from solid color
    /**
     Creates a new solid color image.

     - Parameter color: The color to fill the image with.
     - Parameter size: Image size (defaults: 10x10)

     - Returns A new image
     */
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 10, height: 10)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    // MARK:  Image from gradient colors
    /**
     Creates a gradient color image.

     - Parameter gradientColors: An array of colors to use for the gradient.
     - Parameter size: Image size (defaults: 10x10)

     - Returns A new image
     */
    public convenience init?(gradientColors: [UIColor], size: CGSize = CGSize(width: 10, height: 10)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map { (color: UIColor) -> AnyObject? in
            color.cgColor as AnyObject?
        } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    public convenience init?(QRCodeString: String, size: CGSize = CGSize(width: 280, height: 280)) {
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()

        let data = QRCodeString.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")

        let outputImage = filter.outputImage

        guard let ciImage = outputImage?.resizeCIImage(size: size),
              let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
          else {
            return nil
        }

        self.init(cgImage: cgImage)
    }

    public convenience init?(BarcodeString: String, size: CGSize = CGSize(width: 300, height: 100)) {
        let filter = CIFilter.code128BarcodeGenerator()
        let context = CIContext()

        let data = BarcodeString.data(using: .utf8)
        filter.setValue(data, forKey: "inputMessage")

        let outputImage = filter.outputImage

        guard let ciImage = outputImage?.resizeCIImage(size: size),
              let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
          else {
            return nil
        }

        self.init(cgImage: cgImage)
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

    // MARK: Image from UIView
    /**
     Creates an image from a UIView.

     - Parameter fromView: The source view.

     - Returns A new image
     */
    public convenience init?(fromView view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        //view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }

    // MARK: Image with Radial Gradient
    // Radial background originally from: http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html
    /**
     Creates a radial gradient.

     - Parameter startColor: The start color
     - Parameter endColor: The end color
     - Parameter radialGradientCenter: The gradient center (default:0.5,0.5).
     - Parameter radius: Radius size (default: 0.5)
     - Parameter size: Image size (default: 100x100)

     - Returns A new image
     */
    public convenience init?(startColor: UIColor, endColor: UIColor, radialGradientCenter: CGPoint = CGPoint(x: 0.5, y: 0.5), radius: Float = 0.5, size: CGSize = CGSize(width: 100, height: 100)) {

        // Init
        UIGraphicsBeginImageContextWithOptions(size, true, 0)

        let num_locations: Int = 2
        let locations: [CGFloat] = [0.0, 1.0] as [CGFloat]

        let startComponents = startColor.cgColor.components!
        let endComponents = endColor.cgColor.components!

        let components: [CGFloat] = [startComponents[0], startComponents[1], startComponents[2], startComponents[3], endComponents[0], endComponents[1], endComponents[2], endComponents[3]]

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: components, locations: locations, count: num_locations)

        // Normalize the 0-1 ranged inputs to the width of the image
        let aCenter = CGPoint(x: radialGradientCenter.x * size.width, y: radialGradientCenter.y * size.height)
        let aRadius = CGFloat(min(size.width, size.height)) * CGFloat(radius)

        // Draw it
        UIGraphicsGetCurrentContext()?.drawRadialGradient(gradient!, startCenter: aCenter, startRadius: 0, endCenter: aCenter, endRadius: aRadius, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        // Clean up
        UIGraphicsEndImageContext()
    }
}

@available(macCatalyst 13.0, *)
extension UIImage {

    /**
     A singleton shared NSURL cache used for images from URL
     */
    static var shared: NSCache<AnyObject, AnyObject>! {
        struct StaticSharedCache {
            static var shared: NSCache<AnyObject, AnyObject>? = NSCache()
        }

        return StaticSharedCache.shared!
    }

    // useful for MobileNetV2 coreML model
    public func toCVPixelBuffer() -> CVPixelBuffer? {

        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(self.size.width), Int(self.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)

        UIGraphicsPushContext(context!)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

        return pixelBuffer
    }

    // return [r, g, b, a]: range [0-255, 0-255, 0-255, 0 - 1]
    public func getPixel(atRelativePoint point: CGPoint) -> [UInt8]? {
        guard point.x < size.width && point.y < size.height else {
            printLog("point(\(point.x), \(point.y) is not in image(\(self.size.width), \(self.size.height)")
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

    public func applyCIFilter(filter: CIFilter?, size: CGSize = CGSize(width: 280, height: 280)) -> UIImage? {

        guard let filter = filter else {
            return nil
        }

        guard filter.inputKeys.contains(kCIInputImageKey) else {
            return nil
        }

        guard let inputImage = CIImage(image: self) else {
            return nil
        }

        // apply filter
        filter.setValue(inputImage, forKey: kCIInputImageKey)

        let context = CIContext()
        let outputImage = filter.outputImage
        guard let ciImage = outputImage?.resizeCIImage(size: size),
              let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
          else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }


    /**
     Applies gradient color overlay to an image.

     - Parameter gradientColors: An array of colors to use for the gradient.
     - Parameter blendMode: The blending type to use.

     - Returns A new image
     */
    public func applyGradientColors(_ gradientColors: [UIColor], blendMode: CGBlendMode = CGBlendMode.normal) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(blendMode)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.draw(self.cgImage!, in: rect)
        // Create gradient
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map { (color: UIColor) -> AnyObject? in
            color.cgColor as AnyObject?
        } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        // Apply gradient
        context?.clip(to: rect, mask: self.cgImage!)
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions(rawValue: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!;
    }


    // MARK: Image with Text
    /**
     Create a text at customer position in image.

     - Parameter text: The text to use.
     - Parameter font: The font (default: System font of size 11)
     - Parameter textColor: The text color (default: Orange)
     - Parameter position: text position in image (default: 0x0)

     - Returns A new image
     */

    public func addText(_ text: String, font: UIFont = UIFont.systemFont(ofSize: 11), textColor: UIColor = UIColor.orange, position: CGPoint = CGPoint(x: 0, y: 0)) -> UIImage {

        assert(self.size.width > position.x && self.size.height > position.y, "text must in image")

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

        let rect = CGRect(x: position.x, y: position.y, width: self.size.width - position.x, height: self.size.height - position.y)

        let textFontAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
        (text as NSString).draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()


        return newImage!
    }

    /**
     Create a text in the center of image

     - parameter text:      The text to use.
     - parameter font:      The font (default: System font of size 11)
     - parameter textColor: textColor: The text color (default: Orange)

     - returns: a new image
     */

    public func addTextInCenter(_ text: String, font: UIFont = UIFont.systemFont(ofSize: 11), textColor: UIColor = UIColor.orange) -> UIImage {

        let textFontAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]

        let nsText = NSAttributedString(string: text, attributes: textFontAttributes)

        let centerPosition = CGPoint(x: self.size.width / 2 - nsText.size().width / 2, y: self.size.height / 2 - nsText.size().height / 2)

        let newImage = self.addText(text, font: font, textColor: textColor, position: centerPosition)

        return newImage
    }


    // MARK: add an image to an Image (waterMark)


    public func addImage(_ image: UIImage, position: CGPoint = CGPoint(x: 0, y: 0)) -> UIImage {

        assert(self.size.width > position.x && self.size.height > position.y, "added image must in original image")

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

        let rect = CGRect(x: position.x, y: position.y, width: image.size.width, height: image.size.height)

        image.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return newImage!
    }

    // MARK: Alpha

    /**
     Returns true if the image has an alpha layer.
     */
    public func hasAlpha() -> Bool {
        let alpha = self.cgImage!.alphaInfo
        switch alpha {
        case .first, .last, .premultipliedFirst, .premultipliedLast:
            return true
        default:
            return false

        }
    }

    /**
     Returns a copy of the given image, adding an alpha channel if it doesn't already have one.
     */
    public func applyAlpha() -> UIImage? {
        if hasAlpha() {
            return self
        }

        let imageRef = self.cgImage;
        let width = imageRef?.width;
        let height = imageRef?.height;
        let colorSpace = imageRef?.colorSpace

        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let offscreenContext = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)

        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
        offscreenContext?.draw(imageRef!, in: CGRect(x: 0, y: 0, width: CGFloat(width!), height: CGFloat(height!)))
        let imageWithAlpha = UIImage(cgImage: (offscreenContext?.makeImage()!)!)
        return imageWithAlpha
    }

    // MARK: Crop

    /**
     Creates a cropped copy of an image.

     - Parameter bounds: The bounds of the rectangle inside the image.

     - Returns A new image
     */
    public func crop(_ bounds: CGRect) -> UIImage {
        UIImage(cgImage: (self.cgImage?.cropping(to: bounds)!)!,
          scale: self.scale, orientation: self.imageOrientation)
    }

    public func cropToSquare() -> UIImage {
        let size = CGSize(width: self.size.width * self.scale, height: self.size.height * self.scale)
        let shortest = min(size.width, size.height)
        let left: CGFloat = size.width > shortest ? (size.width - shortest) / 2 : 0
        let top: CGFloat = size.height > shortest ? (size.height - shortest) / 2 : 0
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let insetRect = rect.insetBy(dx: left, dy: top)
        return crop(insetRect)
    }

    // rotate
    public func rotate(by angle: Angle) -> UIImage? {
        let width = self.size.width * self.scale
        let height = self.size.height * self.scale

        let bytesPerRow = width * 4 // image bytes per prw
        let alphaInfo = CGImageAlphaInfo.premultipliedLast
        guard let bmContext = CGContext(
          data: nil,
          width: Int(width),
          height: Int(height),
          bitsPerComponent: 8,
          bytesPerRow: Int(bytesPerRow),
          space: CGColorSpaceCreateDeviceRGB(),
          bitmapInfo: CGBitmapInfo(rawValue: 0).rawValue | alphaInfo.rawValue
        ) else {
            return nil
        }

        guard let cgImage = self.cgImage else {
            return nil
        }
        bmContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        // rotate
        let data = bmContext.data
        var src = vImage_Buffer(data: data, height: UInt(height), width: UInt(width), rowBytes: Int(bytesPerRow))
        var dest = vImage_Buffer(data: data, height: UInt(height), width: UInt(width), rowBytes: Int(bytesPerRow))
        var bgColor: Array<UInt8> = [0, 0, 0, 0]
        vImageRotate_ARGB8888(&src, &dest, nil, Float(-angle.radians), &bgColor, UInt32(kvImageBackgroundColorFill))
        let rotateImageRef = bmContext.makeImage()
        guard let cgRef = rotateImageRef else {
            return nil
        }
        let rotateImage = UIImage(cgImage: cgRef, scale: self.scale, orientation: self.imageOrientation)
        return rotateImage
    }


    // MARK: Resize

    /**
     Creates a resized copy of an image.

     - Parameter size: The new size of the image.
     - Parameter contentMode: The way to handle the content in the new size.

     - Returns A new image
     */
    public func resize(_ size: CGSize, contentMode: UIImageContentMode = .scaleToFill) -> UIImage? {
        let horizontalRatio = size.width / self.size.width;
        let verticalRatio = size.height / self.size.height;
        var ratio: CGFloat!

        switch contentMode {
        case .scaleToFill:
            ratio = 1
        case .scaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .scaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)

        // Fix for a colorspace / transparency issue that affects some types of
        // images. See here: http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/comment-page-2/#comment-39951

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        let transform = CGAffineTransform.identity

        // Rotate and/or flip the image if required by its orientation
        context?.concatenate(transform);

        // Set the quality level to use when rescaling
        context!.interpolationQuality = CGInterpolationQuality(rawValue: 3)!

        //CGContextSetInterpolationQuality(context, CGInterpolationQuality(kCGInterpolationHigh.value))

        // Draw into the context; this scales the image
        context?.draw(self.cgImage!, in: rect)

        // Get the resized image from the context and a UIImage
        let newImage = UIImage(cgImage: (context?.makeImage()!)!, scale: self.scale, orientation: self.imageOrientation)
        return newImage;
    }


    // MARK: Corner Radius

    /**
     Creates a new image with rounded corners.

     - Parameter cornerRadius: The corner radius.

     - Returns A new image
     */
    public func roundCorners(_ cornerRadius: CGFloat) -> UIImage? {
        // If the image does not have an alpha layer, add one
        let imageWithAlpha = applyAlpha()
        if imageWithAlpha == nil {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = imageWithAlpha?.cgImage?.width
        let height = imageWithAlpha?.cgImage?.height
        let bits = imageWithAlpha?.cgImage?.bitsPerComponent
        let colorSpace = imageWithAlpha?.cgImage?.colorSpace
        let bitmapInfo = imageWithAlpha?.cgImage?.bitmapInfo
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        let rect = CGRect(x: 0, y: 0, width: CGFloat(width!) * scale, height: CGFloat(height!) * scale)

        context?.beginPath()
        if (cornerRadius == 0) {
            context?.addRect(rect)
        } else {
            context?.saveGState()
            context?.translateBy(x: rect.minX, y: rect.minY)
            context?.scaleBy(x: cornerRadius, y: cornerRadius)
            let fw = rect.size.width / cornerRadius
            let fh = rect.size.height / cornerRadius
            context?.move(to: CGPoint(x: fw, y: fh / 2))
            context?.addArc(tangent1End: CGPoint(x: fw, y: fh), tangent2End: CGPoint(x: fw / 2, y: fh), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: 0, y: fh), tangent2End: CGPoint(x: 0, y: fh / 2), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: 0, y: 0), tangent2End: CGPoint(x: fw / 2, y: 0), radius: 1)
            context?.addArc(tangent1End: CGPoint(x: fw, y: 0), tangent2End: CGPoint(x: fw, y: fh / 2), radius: 1)
            context?.restoreGState()
        }
        context?.closePath()
        context?.clip()

        context?.draw((imageWithAlpha?.cgImage)!, in: rect)
        let image = UIImage(cgImage: (context?.makeImage()!)!, scale: scale, orientation: .up)
        UIGraphicsEndImageContext()
        return image
    }


    /**
     Creates a new image with rounded corners and border.

     - Parameter cornerRadius: The corner radius.
     - Parameter border: The size of the border.
     - Parameter color: The color of the border.

     - Returns A new image
     */
    public func roundCorners(_ cornerRadius: CGFloat, border: CGFloat, color: UIColor) -> UIImage? {
        roundCorners(cornerRadius)?.applyBorder(border, color: color)
    }

    /**
     Creates a new circle image.

     - Returns A new image
     */
    public func circleImage() -> UIImage? {
        let squareCurrentImage = self.cropToSquare()
        let radius = min(squareCurrentImage.size.width, squareCurrentImage.size.height) / 2
        return squareCurrentImage.roundCorners(radius)
    }

    /**
     Creates a new circle image with a border.

     - Parameter border :CGFloat The size of the border.
     - Parameter color :UIColor The color of the border.

     - Returns UIImage?
     */
    public func circleImageWithBorder(border: CGFloat, color: UIColor) -> UIImage? {
        let squareCurrentImage = self.cropToSquare()
        let radius = min(squareCurrentImage.size.width, squareCurrentImage.size.height) / 2
        return squareCurrentImage.roundCorners(radius, border: border, color: color)
    }


    // MARK: Border

    /**
     Creates a new image with a border.

     - Parameter border: The size of the border.
     - Parameter color: The color of the border.

     - Returns A new image
     */
    public func applyBorder(_ border: CGFloat, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let width = self.cgImage?.width
        let height = self.cgImage?.height
        let bits = self.cgImage?.bitsPerComponent
        let colorSpace = self.cgImage?.colorSpace
        let bitmapInfo = self.cgImage?.bitmapInfo
        let context = CGContext(data: nil, width: width!, height: height!, bitsPerComponent: bits!, bytesPerRow: 0, space: colorSpace!, bitmapInfo: (bitmapInfo?.rawValue)!)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        context?.setLineWidth(border)
        let rect = CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale)
        let inset = rect.insetBy(dx: border * scale, dy: border * scale)
        context?.strokeEllipse(in: inset)
        context?.draw(self.cgImage!, in: inset)
        let image = UIImage(cgImage: (context?.makeImage()!)!)
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: Image Effects

    /**
     Applies a light blur effect to the image

     - Returns New image or nil
     */
    public func applyLightEffect() -> UIImage? {
        applyBlur(30, tintColor: UIColor(white: 1.0, alpha: 0.3), saturationDeltaFactor: 1.8)
    }

    /**
     Applies a extra light blur effect to the image

     - Returns New image or nil
     */
    public func applyExtraLightEffect() -> UIImage? {
        applyBlur(20, tintColor: UIColor(white: 0.97, alpha: 0.82), saturationDeltaFactor: 1.8)
    }

    /**
     Applies a dark blur effect to the image

     - Returns New image or nil
     */
    public func applyDarkEffect() -> UIImage? {
        applyBlur(20, tintColor: UIColor(white: 0.11, alpha: 0.73), saturationDeltaFactor: 1.8)
    }

    /**
     Applies a color tint to an image

     - Parameter color: The tint color

     - Returns New image or nil
     */
    public func applyTintEffect(_ tintColor: UIColor) -> UIImage? {
        let effectColorAlpha: CGFloat = 0.6
        var effectColor = tintColor
        let componentCount = tintColor.cgColor.numberOfComponents
        if componentCount == 2 {
            var b: CGFloat = 0
            if tintColor.getWhite(&b, alpha: nil) {
                effectColor = UIColor(white: b, alpha: effectColorAlpha)
            }
        } else {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0

            if tintColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
                effectColor = UIColor(red: red, green: green, blue: blue, alpha: effectColorAlpha)
            }
        }
        return applyBlur(10, tintColor: effectColor, saturationDeltaFactor: -1.0)
    }

    /**
     Applies a blur to an image based on the specified radius, tint color saturation and mask image

     - Parameter blurRadius: The radius of the blur.
     - Parameter tintColor: The optional tint color.
     - Parameter saturationDeltaFactor: The detla for saturation.
     - Parameter maskImage: The optional image for masking.

     - Returns New image or nil
     */
    public func applyBlur(_ blurRadius: CGFloat, tintColor: UIColor?, saturationDeltaFactor: CGFloat, maskImage: UIImage? = nil) -> UIImage? {
        guard size.width > 0 && size.height > 0 && cgImage != nil else {
            return nil
        }
        if maskImage != nil {
            guard maskImage?.cgImage != nil else {
                return nil
            }
        }
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        var effectImage = self
        let hasBlur = blurRadius > CGFloat(Float.ulpOfOne)
        let hasSaturationChange = abs(saturationDeltaFactor - 1.0) > CGFloat(Float.ulpOfOne)
        if (hasBlur || hasSaturationChange) {

            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            let effectInContext = UIGraphicsGetCurrentContext()
            effectInContext?.scaleBy(x: 1.0, y: -1.0)
            effectInContext?.translateBy(x: 0, y: -size.height)
            effectInContext?.draw(cgImage!, in: imageRect)

            var effectInBuffer = vImage_Buffer(
              data: effectInContext?.data,
              height: UInt((effectInContext?.height)!),
              width: UInt((effectInContext?.width)!),
              rowBytes: (effectInContext?.bytesPerRow)!)

            UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
            let effectOutContext = UIGraphicsGetCurrentContext()

            var effectOutBuffer = vImage_Buffer(
              data: effectOutContext?.data,
              height: UInt((effectOutContext?.height)!),
              width: UInt((effectOutContext?.width)!),
              rowBytes: (effectOutContext?.bytesPerRow)!)

            if hasBlur {
                let inputRadius = blurRadius * UIScreen.main.scale
                let sqrtPi: CGFloat = CGFloat(sqrt(.pi * 2.0))
                var radius = UInt32(floor(inputRadius * 3.0 * sqrtPi / 4.0 + 0.5))
                if radius % 2 != 1 {
                    radius += 1 // force radius to be odd so that the three box-blur methodology works.
                }
                let imageEdgeExtendFlags = vImage_Flags(kvImageEdgeExtend)
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
            }

            var effectImageBuffersAreSwapped = false

            if hasSaturationChange {
                let s: CGFloat = saturationDeltaFactor
                let floatingPointSaturationMatrix: [CGFloat] = [
                    0.0722 + 0.9278 * s, 0.0722 - 0.0722 * s, 0.0722 - 0.0722 * s, 0,
                    0.7152 - 0.7152 * s, 0.7152 + 0.2848 * s, 0.7152 - 0.7152 * s, 0,
                    0.2126 - 0.2126 * s, 0.2126 - 0.2126 * s, 0.2126 + 0.7873 * s, 0,
                    0, 0, 0, 1
                ]

                let divisor: CGFloat = 256
                let matrixSize = floatingPointSaturationMatrix.count
                var saturationMatrix = [Int16](repeating: 0, count: matrixSize)

                for i: Int in 0..<matrixSize {
                    saturationMatrix[i] = Int16(round(floatingPointSaturationMatrix[i] * divisor))
                }

                if hasBlur {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                    effectImageBuffersAreSwapped = true
                } else {
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                }
            }

            if !effectImageBuffersAreSwapped {
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }

            UIGraphicsEndImageContext()

            if effectImageBuffersAreSwapped {
                effectImage = UIGraphicsGetImageFromCurrentImageContext()!
            }

            UIGraphicsEndImageContext()
        }

        // Set up output context.
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let outputContext = UIGraphicsGetCurrentContext()
        outputContext?.scaleBy(x: 1.0, y: -1.0)
        outputContext?.translateBy(x: 0, y: -size.height)

        // Draw base image.
        outputContext?.draw(self.cgImage!, in: imageRect)

        // Draw effect image.
        if hasBlur {
            outputContext?.saveGState()
            if let image = maskImage {
                outputContext?.clip(to: imageRect, mask: image.cgImage!);
            }
            outputContext?.draw(effectImage.cgImage!, in: imageRect)
            outputContext?.restoreGState()
        }

        // Add in color tint.
        if let color = tintColor {
            outputContext?.saveGState()
            outputContext?.setFillColor(color.cgColor)
            outputContext?.fill(imageRect)
            outputContext?.restoreGState()
        }

        // Output image is ready.
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return outputImage
    }

    public func extractQRCode() -> [String]? {
        //1. 创建过滤器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)

        //2. 获取CIImage
        guard let ciImage = CIImage(image: self) else {
            return nil
        }

        //3. 识别二维码
        guard let features = detector?.features(in: ciImage) else {
            return nil
        }

        //4. 遍历数组, 获取信息
        return features.compactMap { feature in
            (feature as? CIQRCodeFeature)?.messageString
        }
    }


    // MARK: Image From URL

    /**
     Creates a new image from a URL with optional caching. If cached, the cached image is returned. Otherwise, a place holder is used until the image from web is returned by the closure.

     - Parameter url: The image URL.
     - Parameter placeholder: The placeholder image.
     - Parameter shouldCacheImage: whither or not we should cache the NSURL response (default: true)
     - Parameter closure: Returns the image from the web the first time is fetched.

     - Returns A new image
     */
    class public func image(
      fromURL url: String,
      shouldCacheImage: Bool? = true,
      placeholder: UIImage? = nil,
      onSuccess: ((_ image: UIImage?) -> Void)? = nil,
      onError: ((_ err: Error) -> Void)?
    ) -> UIImage? {
        // From Cache
        if shouldCacheImage != nil && shouldCacheImage! {
            if let image = UIImage.shared.object(forKey: url as AnyObject) as? UIImage {
                onSuccess?(image)
                return image
            }
        }
        // Fetch Image
        let session = URLSession(configuration: URLSessionConfiguration.default)
        if let nsURL = URL(string: url) {
            session.dataTask(with: nsURL, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    DispatchQueue.main.async {
                        onError?(error)
                    }
                }
                if let data = data, let image = UIImage(data: data) {
                    if shouldCacheImage != nil && shouldCacheImage! {
                        UIImage.shared.setObject(image, forKey: url as AnyObject)
                    }
                    DispatchQueue.main.async {
                        onSuccess?(image)
                    }
                } else {
                    onError?(CustomError("url data is not an image"))
                }
                session.finishTasksAndInvalidate()
            }).resume()
        }
        return placeholder
    }
}

// Vision related
@available(macCatalyst 13.0, *)
extension UIImage {

    public func addVNFaceObservation(
      observations: [VNFaceObservation],
      color: UIColor = .red,
      lineWidth: CGFloat = 5.0
    ) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width * self.scale, height: self.size.height * self.scale))

        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)

        let transform = CGAffineTransform(scaleX: 1 * self.scale, y: -1 * self.scale)
          .translatedBy(x: 0, y: -self.size.height * self.scale)

        for observation in observations {
            let rect = observation.boundingBox

            let normalizedRect = VNImageRectForNormalizedRect(rect, Int(self.size.width * self.scale), Int(self.size.height * self.scale))
              .applying(transform)
            context.stroke(normalizedRect)
        }

        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return result
    }
}
