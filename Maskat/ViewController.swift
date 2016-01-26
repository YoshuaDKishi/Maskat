//
//  ViewController.swift
//  Maskat
//
//  Created by YoshiakiKishi on 2016/01/21.
//  Copyright © 2016年 Yoshua Dilham Kishi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var post = Post.allPosts
    
    
    private var newButton: ActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "postCell")
        
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = UIColor(hex: "#90d52e")
        
        title = "Maskat"
        createNewButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createNewButton(){
        
        newButton = ActionButton(attachedToView: self.view, items: [])
        newButton.action = { button in
            print ("Post Button Pressed")
            self.performSegueWithIdentifier("New Post Composer", sender: self)
            
        }
        
        newButton.backgroundColor = UIColor.greenColor()
        
        
    }
    
    
    //データをページ移動の際に一緒に移動させる
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier ==  "Show Comment Page"{
            
            let commentViewController = segue.destinationViewController as! CommentViewController
            
            commentViewController.post = sender as! Post
        
        }
    
    }


}




extension ViewController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return post.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        cell.post = post[indexPath.row]
        
        cell.delegate = self
        
        return cell
    }
    
    
    
}

extension ViewController: PostTableViewCellDelegate{
    
    func commentButton_Clicked(post: Post) {
       
        self.performSegueWithIdentifier("Show Comment Page", sender: post)
        
    }
    
}







