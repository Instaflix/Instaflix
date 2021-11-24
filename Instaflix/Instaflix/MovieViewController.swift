//
//  MovieTableViewController.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/16/21.
//

import UIKit
import Parse
import AlamofireImage
import TMDBSwift

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //movieId from previous screen
    var movieID: Int? //doesn't run so do segue way
    var movie: MovieMDB!
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    //dangerous practice for apikeys
    //let TMDBapikey = "34872395426d9e0ba548d1d51cbd6c10"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("=====> ", movie.title)
        
        titleLabel.text = movie.title
        synopsisLabel.text = movie.overview

        let posterPath = movie.poster_path as String?
        let backdropPath = movie.backdrop_path as String?
        let baseURL =  "https://image.tmdb.org/t/p/w780"

        let posterUrl = URL(string: baseURL + posterPath!)
        let backdropUrl = URL(string: baseURL + backdropPath!)
        
        
        backDropView.af.setImage(withURL: backdropUrl!)
        posterView.af.setImage(withURL: posterUrl!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailsViewController = segue.destination as! CommentViewController
        detailsViewController.movie = movie
        
    }
    
    
    @IBAction func onReadCommentClick(_ sender: Any) {
        self.performSegue(withIdentifier: "movieToComments", sender: self)
    }
    
}
