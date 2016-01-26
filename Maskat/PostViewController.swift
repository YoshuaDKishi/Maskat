//
//  PostViewController.swift
//  Maskat
//
//  Created by YoshiakiKishi on 2016/01/25.
//  Copyright © 2016年 Yoshua Dilham Kishi. All rights reserved.
//

import UIKit
import Photos

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var navaigationBar: UINavigationBar!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    
    private var PostImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navaigationBar.tintColor = UIColor.whiteColor()
        navaigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navaigationBar.barTintColor = UIColor(hex: "#90d52e")
        
        
        //画像を丸める
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width/2
        userProfileImage.clipsToBounds = true
        
        
        
        //テキストの編集
        
        postText.text = ""
        postText.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
      
        //Notification Center
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardWillHide(notification: NSNotification){
        
        self.postText.contentInset = UIEdgeInsetsZero
        self.postText.scrollIndicatorInsets = UIEdgeInsetsZero
        
        
    }
    
    func keyboardWillShow(notification: NSNotification){
        
        let userInfo = notification.userInfo ?? [:]
        let keyboardSize = ( userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        self.postText.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height+10, right: 0)
        self.postText.scrollIndicatorInsets = self.postText.contentInset
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func backButton_Clicked(sender: AnyObject) {
        
        postText.resignFirstResponder()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func postButton_Clicked(sender: AnyObject) {
        
        postText.resignFirstResponder()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    

}


extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBAction func PicFeaturedImage(sender: AnyObject) {
        
        
        let authorization = PHPhotoLibrary.authorizationStatus()
        
        if authorization == .NotDetermined {
            
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                dispatch_barrier_async(dispatch_get_main_queue(), { () -> Void in
                    self.PicFeaturedImage(sender)
                })
            })
            return
            
        }
        
        if authorization == .Authorized {
            
            let controller = ImagePickerSheetController()
            controller.addAction(ImageAction(title: NSLocalizedString("Take a Photo or Video!", comment: "ActionTitle"),secondaryTitle: NSLocalizedString("Use this one!", comment: "ActionTitle"), handler: { (_) -> () in
                self.presentCamera()
                
                }, secondaryHandler: { (action, numberOfPhoto) -> ()in
                    
                    controller.getSelectedImagesWithCompletion({ (images) -> Void in
                        self.PostImage = images[0]
                        self.postImage.image = self.PostImage
                    })
                    
                    
            }))
            
            
            controller.addAction(ImageAction(title: NSLocalizedString("Cancel", comment: "ActionTitle"), style: .Cancel, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
            
            
                  }
        
        
        
    }
    
    
    
    func presentCamera(){
        
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.postImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}




    
    




