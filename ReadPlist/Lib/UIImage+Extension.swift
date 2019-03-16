//
//  UIImage+Extension.swift
//  ReadPlist
//
//  Created by Ievgen Gavrysh on 3/15/19.
//  Copyright © 2019 Stanislav Cherkasov. All rights reserved.
//

import UIKit

extension UIImage {
  func imageByMakingWhiteBackgroundTransparent() -> UIImage? {
    let image = UIImage(data: self.jpegData(compressionQuality: 1.0)!)!
    let rawImageRef: CGImage =  image.cgImage!
    
    let colorMasking: [CGFloat] = [250, 255, 250, 255, 244, 255]
    UIGraphicsBeginImageContext(image.size)
    
    let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
    UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image.size.height)
    UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
    UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
    let result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result
  }
}
