//
//  GalleryCustomFlowLayout.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/17/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout
{
    var columns: Int
    var spacing: CGFloat = 1.0
    
    init(columns: Int = 3) {
        
        self.columns = columns
        super.init()
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init has not been implemented")
    }
    
    func setup()
    {
        self.minimumLineSpacing = self.spacing
        self.minimumInteritemSpacing = self.spacing
        
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth())
        
    }
    
    func screenWidth() -> CGFloat
    {
        return CGRectGetWidth(UIScreen.mainScreen().bounds)
    }
    
    func itemWidth() -> CGFloat
    {
        let width = self.screenWidth()
        let availableWidth = width - (CGFloat(self.columns) * self.spacing)
        return availableWidth / CGFloat(self.columns)
    }
    
}

