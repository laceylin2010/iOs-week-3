//
//  GalleryViewController.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/17/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = [Post]()
        {
        didSet{
            self.collectionView.reloadData()
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
        self.navigationItem.title = "Gallery"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func update()
    {
        API.shared.GETPOST { (posts) -> () in
            if let posts = posts {
                self.dataSource = posts
                print(posts)
            } else { print ("no posts")}
        }
    }

}

extension GalleryViewController
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.dataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let galleryCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        galleryCell.post = self.dataSource[indexPath.row]
        
        return galleryCell
    }
}