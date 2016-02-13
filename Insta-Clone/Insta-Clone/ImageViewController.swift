//
//  ImageViewController.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/12/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    lazy var imagePicker = UIImagePickerController()

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }
    
    func presentImagePicker(source: UIImagePickerControllerSourceType )
    {
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = source
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addImageButton(sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(.Camera)
        {
            presentActionSheet()
            
        } else {
            self.presentImagePicker(.PhotoLibrary)
            
        }
        
    }

    func presentActionSheet()
    {
        let actionSheet = UIAlertController(title: "Source", message: "Please pick source type", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) -> Void in
            self.presentImagePicker(.Camera)
        }
        
        let photoAction = UIAlertAction(title: "Photo Library", style: .Default) { (action) -> Void in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
}

extension ImageViewController
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
