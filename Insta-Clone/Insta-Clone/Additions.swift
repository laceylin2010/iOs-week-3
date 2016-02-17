//
//  Additions.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

extension UIImage
{
    class func resize (image: UIImage, size: CGSize) -> UIImage
    {
     UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension NSURL
{
    class func imageURL() -> NSURL
    {
        guard let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else { fatalError() }
        print(documentsDirectory)
        return documentsDirectory.URLByAppendingPathComponent("image")
    }
    

}