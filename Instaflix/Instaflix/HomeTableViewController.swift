//
//  HomeTableViewController.swift
//  Instaflix
//
//  Created by Ciara Morell on 11/14/21.
//

import UIKit
import Parse
import AlamofireImage
import TMDBSwift

class HomeTableViewController: UITableViewController {
    
    var selectedMovieID: Int?
    
    var movies = [MovieMDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        //let apikey = "34872395426d9e0ba548d1d51cbd6c10"

        DiscoverMovieMDB.discoverMovies(language: "EN", page: 1, sort_by: DiscoverSortByMovie.popularity_desc){ data, movieArr in
            self.movies = movieArr!
            self.tableView.reloadData()
        }
        
    }
    
       
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
                
        delegate.window?.rootViewController = loginViewController
        
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        print("Hi")
    }
    
    
    
   
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //cell.textLabel?.text = "row: \(indexPath.row)"
        print("indexPath.row ===> ", indexPath.row)
        print("movies ===> ", movies.count)
        //print("movies[i] ===> ", self.movies[indexPath.row])
        let movie = movies[indexPath.row]
        cell.title.text = movie.title!
        cell.synopsis.text = movie.overview!
        
        let posterPath = movie.poster_path as String?
        let baseURL =  "https://image.tmdb.org/t/p/w185"        
        let url = URL(string: baseURL + posterPath!)
        cell.posterImage?.af_setImage(withURL: url!)

        return cell
    }

    //delete the button and keep this code and the segue?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieViewController {
            let vc = segue.destination as? MovieViewController
            vc?.movieID = 550
        }
        print("====> loading up the details....")
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let movie = movies[indexPath!.row]
        
        let detailsViewController = segue.destination as! MovieViewController
        detailsViewController.movie = movie
        
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func testMovieDisplay(_ sender: Any) {
        selectedMovieID = 550
        self.performSegue(withIdentifier: "homeToMovie", sender: self)
        
    }
    
}
