//
//  ClassFilters.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

class filters
{
    
    typealias FiltersCompletion = (theimage: UIImage?) -> ()
    
    private class func filter(name: String, image: UIImage, completion: (FiltersCompletion)) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            guard let filter = CIFilter(name: name) else { fatalError("Check filter spelling.") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace : NSNull()]
            let EAGContext = EAGLContext(API: .OpenGLES2)
            let GPUContext = CIContext(EAGLContext: EAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Y no Image?") }
            let CGImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theimage: UIImage(CGImage: CGImage))
            })
        }

    }
    
    class func blackWhite(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func pixelate(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPixellate", image: image, completion: completion)
    }
    class func chrome(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    class func invert(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorInvert", image: image, completion: completion)
    }
    class func transfer(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
}



