//
//  ImageViewController.swift
//  Insta-Clone
//
//  Created by Lacey Vu on 2/12/16.
//  Copyright © 2016 Lacey Vu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FilterPreviewDelegate, SegueHandlerType
{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var originalImage = UIImage?()
    
    
    enum SegueIdentifier: String
    {
        case Preview = "FiltersPreviewViewController"
    }
 
    
    lazy var imagePicker = UIImagePickerController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
       
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        switch self.segueIdentifierForSegue(segue)
        {
        case .Preview:
            guard let previewViewController = segue.destinationViewController as? FiltersPreviewViewController else {  fatalError() }
            guard let image = sender as? UIImage else { fatalError() }
            
            previewViewController.image = image
            previewViewController.delegate = self
        }
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
        self.performSegueWithIdentifier(.Preview, sender: image)
        
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
        
        UIImage.resize(image, size: CGSize(width: 500, height: 800))
        
        self.imageView.image = image
        self.originalImage = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func filtersPreviewViewControllerDidFinish(image: UIImage) {
        self.imageView.image = image
    }
}
