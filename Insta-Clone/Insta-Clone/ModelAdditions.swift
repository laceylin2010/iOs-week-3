//
//  ModelAdditions.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/16/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import CloudKit
import UIKit

enum PostError: ErrorType
{
    case WritingImage
    case CreatingCKRecord
}

extension Post
{
    class func recordWith(post: Post) throws -> CKRecord?
    {
        let imageURL = NSURL.imageURL()
        print(imageURL)
        print(post.image)
        
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage }
        
        let saved = data.writeToURL(imageURL, atomically: true)
        
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "post")
            
            record.setObject(asset, forKey: "image")
            
            return record
        } else { throw PostError.CreatingCKRecord }
    }
}

