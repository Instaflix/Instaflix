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
    var movieCommentsList = [PFObject]()
    
    let commentBar = MessageInputBar()
    var showCommentBar = true
    
    
    var selectedPost: PFObject!
    
    var refreshControl: UIRefreshControl!
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let query = PFQuery(className:"MovieComments")
        query.whereKey("movieId", equalTo: movie.id)
        query.includeKeys(["author", "comments"])
        query.limit = 20

        query.findObjectsInBackground { (movieCommentsList, error) in
            if movieCommentsList != nil {
                self.movieCommentsList = movieCommentsList!
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        commentBar.inputTextView.placeholder = "Add a comment.."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
                
        tableView.dataSource = self
        tableView.delegate = self

    
        tableView.keyboardDismissMode = .interactive
                
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

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
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
  
        let comment = PFObject(className: "MovieComments")
        comment["text"] = text
        comment["movieId"] = movie.id
        comment["author"] = PFUser.current()!
        movieCommentsList.append(comment)
        comment.saveInBackground {(success, error) in
            if success {
                print ("Comment saved")
                self.tableView.reloadData()
            } else {
                print ("Error saving comment : ", error)
            }
        }
      
        commentBar.inputTextView.text = nil
        showCommentBar = false
        becomeFirstResponder()
    }
    
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCommentsList.count
    }
    
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieComment = movieCommentsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        
        print("MovieComment ===> ", movieComment)
        
        let author = movieComment["author"] as! PFUser
        cell.usernameLabel.text = author.username
        cell.commentLabel.text = movieComment["text"] as! String
        
        return cell
        
    }
        
}
