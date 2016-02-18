//
//  FiltersPreviewViewController.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/18/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit



protocol FilterPreviewDelegate: class
{
    
    func filtersPreviewViewControllerDidFinish(image: UIImage)
    
}

class FiltersPreviewViewController: UIViewController, Identity
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var image: UIImage!
    weak var delegate: FilterPreviewDelegate?
    let datasource = [Filters.shared.originalImage,Filters.shared.blackWhite, Filters.shared.chrome, Filters.shared.invert, Filters.shared.pixelate, Filters.shared.transfer]

    class func id() -> String
    {
        return "FiltersPreviewViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupCollectionView()
    {
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }

}




