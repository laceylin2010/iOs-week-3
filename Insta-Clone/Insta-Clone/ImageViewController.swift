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
    
    var originalImage = UIImage?()
 
    
    lazy var imagePicker = UIImagePickerController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let filterNames = CIFilter.filterNamesInCategories(nil)
        print(filterNames)
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
    
    @IBAction func editButtonSelected(sender: AnyObject)
    {
        
        guard let image = self.imageView.image else { return }
        let actionSheet = UIAlertController(title: "filters", message: "Please select a filter", preferredStyle: .Alert)
        
        let pixels = UIAlertAction(title: "Pixels", style: .Default) { (action) -> Void in
            filters.pixelate(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        
        let bwAction = UIAlertAction(title: "Black and White", style: .Default) { (action) -> Void in
            filters.blackWhite(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .Default) { (action) -> Void in
            filters.chrome(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        
        let invertAction = UIAlertAction(title: "Invert", style: .Default) { (action) -> Void in
            filters.invert(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        
        let transferAction = UIAlertAction(title: "Transfer", style: .Default) { (action) -> Void in
            filters.transfer(image, completion: { (theImage) -> () in
                self.imageView.image = theImage
            })
        }
        

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) -> Void in
            self.imageView.image = self.originalImage
        }
    
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(pixels)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(invertAction)
        actionSheet.addAction(transferAction)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(resetAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }

    @IBAction func saveButtonSelected(sender: AnyObject)
    {
    
        guard let image = self.imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
        API.shared.post(Post(image: image)) { (success) -> () in
            if success {
                print("Cloudkit Saved")
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>)
    {
        if error == nil {
            let alertController = UIAlertController(title: "Saved!", message: "The image has been saved to your photo album", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
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
        self.originalImage = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
