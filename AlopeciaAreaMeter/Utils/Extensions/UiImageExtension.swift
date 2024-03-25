//
//  UiImageExtension.swift
//  ImageRendering
//
//  Created by Mujtaba Hassan on 22/03/2024.
//

import Foundation
import UIKit
import CoreGraphics
import VideoToolbox
import AVKit
import Accelerate


extension CIImage {
    // MARK: Function to convert CIImage to CGImage
    func convert(cmage: CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context: CIContext? = CIContext(options: nil)
        
        if context != nil {
            return context?.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
}
    
extension UIImage {
    func changeImageColor(color: UIColor) -> UIImage {
        return self.withRenderingMode(.alwaysTemplate).withTintColor(color)
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let scale: CGFloat = 5.0
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        //   let rect = CGRect(origin: .zero, size: newSize)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func convertCGImageToCIImage(inputImage: CGImage) -> CIImage! {
        let ciImage = CIImage(cgImage: inputImage)
        return ciImage
    }
    
    // Convert Pixel buffer to image
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImagee: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImagee)
        
        guard let cgImage = cgImagee else {
            return nil
        }
        
        self.init(cgImage: cgImage)
    }
    
    static func convert(from ciImage: CIImage) -> UIImage {
        let context: CIContext = CIContext.init(options: nil)
        let cgImage: CGImage = context.createCGImage(ciImage, from: ciImage.extent)!
        let image: UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    func crop(rect: CGRect) -> UIImage {
        var rect = rect
        rect.origin.x*=self.scale
        rect.origin.y*=self.scale
        rect.size.width*=self.scale
        rect.size.height*=self.scale
        
        let imageRef = self.cgImage!.cropping(to: rect)
        let image = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
//    func cropped(to bounds: CGRect) -> UIImage? {
//        // if bounds is entirely within image, do simple CGImage `cropping` ...
//        if CGRect(origin: .zero, size: size).contains(bounds), imageOrientation == .up, let cgImage = cgImage {
//            return cgImage.cropping(to: bounds * scale).flatMap {
//                UIImage(cgImage: $0, scale: scale, orientation: imageOrientation)
//            }
//        }
//        
//        // ... otherwise, manually render whole image, only drawing what we need
//        
//        let format = UIGraphicsImageRendererFormat()
//        format.opaque = false
//        format.scale = scale
//        
//        return UIGraphicsImageRenderer(size: bounds.size, format: format).image { _ in
//            let origin = CGPoint(x: -bounds.minX, y: -bounds.minY)
//            draw(in: CGRect(origin: origin, size: size))
//        }
//    }
}

