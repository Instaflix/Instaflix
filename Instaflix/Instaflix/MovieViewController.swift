//
//  MovieTableViewController.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/16/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar
import TMDBSwift

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //movieId from previous screen
    var movieID: Int? //doesn't run so do segue way
    var movie: MovieMDB!
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    //dangerous practice for apikeys
    //let TMDBapikey = "34872395426d9e0ba548d1d51cbd6c10"
    
    let commentBar = MessageInputBar()
    var showCommentBar = false
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("=====> ", movie.title)
        
        titleLabel.text = movie.title
        synopsisLabel.text = movie.overview

        let posterPath = movie.poster_path as String?
        let baseURL =  "https://image.tmdb.org/t/p/w780"
        let url = URL(string: baseURL + posterPath!)
        backDropView.af_setImage(withURL: url!)
        
        
//        //commentBar setups (MessageInputBar)
//        commentBar.inputTextView.placeholder = "Add a comment.."
//        commentBar.sendButton.title = "Post"
//        commentBar.delegate = self
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        //CommentBar Display?
//        tableView.keyboardDismissMode = .interactive
//        
//        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    
    //not sure what this one is for but it looks like related to comments, or it is the number of rows?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        */
        return 3
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
            
            //print(movieID)
            
            
            //a MovieMDB object's items? are mostly String type except movieID being INT
            //use movieId passed through Segue
            MovieMDB.movie(movieID: self.movieID, language: "en") { (api, movie) in
                cell.title.text = movie?.title
                cell.synopsis.text = movie?.overview
                
                let posterPath = movie?.poster_path as String?
                let baseURL =  "https://image.tmdb.org/t/p/w185"
                
                let url = URL(string: baseURL + posterPath!)
                cell.posterImage.af.setImage(withURL: url!)
            }
            
            return cell
        }
        else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            
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
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
