//
//  UIImage+Extensions.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import UIKit

extension UIImage {
    class func coloredRectangleImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }

}
