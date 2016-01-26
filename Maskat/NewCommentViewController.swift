//
//  NewCommentViewController.swift
//  Maskat
//
//  Created by YoshiakiKishi on 2016/01/26.
//  Copyright © 2016年 Yoshua Dilham Kishi. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var user = User.allUsers()[0]
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.barTintColor = UIColor(hex: "#90d52e")
        
        
        
        commentText.text = ""
        commentText.becomeFirstResponder()
        
        profileImage.image = user.profileImage
        usernameLabel.text! = user.fullName
        
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width/2
        profileImage.clipsToBounds = true
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButton_Clicked(sender: AnyObject) {
        
        commentText.resignFirstResponder()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func commentButton_Clicked(sender: AnyObject) {
        
        commentText.resignFirstResponder()
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}
