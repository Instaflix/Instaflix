//
//  CommentViewController.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/23/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar
import TMDBSwift

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: MovieMDB!
    
    let commentBar = MessageInputBar()
    var showCommentBar = false
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //commentBar setups (MessageInputBar)
        commentBar.inputTextView.placeholder = "Add a comment.."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
                
        tableView.dataSource = self
        tableView.delegate = self

        //CommentBar Display?
        tableView.keyboardDismissMode = .interactive
                
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MessageInputBar object and functions
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showCommentBar
    }
    //end of MessageInputBar object and functions
    
    //this is for the posts limits.. so instead this will be to be modified in the future for query of the comments displayed.
    
    //quick comment: change post author for current movie with a comment (associate movies with comments)
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
     */
    
    //the number of rows?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
         
         //the return should be a comments.count and + 1 just for the add comment bar
        */
        return 2
        
    }
    
    
    //handles number of sections (1 section contains 1 movie cell, 1 comment cell (x comments), 1 add comment cell)
    func numberOfSections(in tableView: UITableView) -> Int {
        //original return was posts.count
        return 1
    }
    
    //handles display of the cells, row 0 is always movie
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let post = posts[indexPath.section]
        //let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            cell.userText.text = "user text in here"
            cell.username.text = "mike"
            
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell") as! AddCommentCell
            
            
            return cell
            
        }
        /*
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell") as! AddCommentCell
            
            
            return cell
        }
         */
        
    }
    
    //Comment section backend template/setup for comment bar posting
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section] //video is .row, but that changed
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
        
    }
     */
    
}
