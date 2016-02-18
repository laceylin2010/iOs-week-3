//
//  ClassFilters.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit



typealias FiltersCompletion = (theimage: UIImage?) -> ()


class Filters
{
    static let shared = Filters()
    let context: CIContext
    
    private init()
    {
        let options = [kCIContextWorkingColorSpace : NSNull()]
        let EAGContext = EAGLContext(API: .OpenGLES2)
        self.context = CIContext(EAGLContext: EAGContext, options: options)
    }
    
    
    private func filter(name: String, image: UIImage, completion: (FiltersCompletion)) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            guard let filter = CIFilter(name: name) else { fatalError("Check filter spelling.") }
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            guard let outputImage = filter.outputImage else { fatalError("Y no Image?") }
            let CGImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theimage: UIImage(CGImage: CGImage))
            })
        }

    }
    
    func originalImage(image: UIImage, completion: FiltersCompletion)
    {
        completion(theimage: image)
    }
    
    func blackWhite(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func pixelate(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPixellate", image: image, completion: completion)
    }
    func chrome(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    func invert(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIColorInvert", image: image, completion: completion)
    }
    func transfer(image: UIImage, completion: FiltersCompletion)
    {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
}



