//
//  ControllerAdditions.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/18/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

extension FiltersPreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        let filter = self.datasource[indexPath.row]
        filter(self.image!, completion: {imageCell.imageView.image = $0})
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.datasource.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let imageCell = collectionView.cellForItemAtIndexPath(indexPath) as? GalleryCollectionViewCell
            else { fatalError() }
        self.delegate?.filtersPreviewViewControllerDidFinish(imageCell.imageView.image!)
    }

}
 