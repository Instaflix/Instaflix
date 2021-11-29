//
//  SearchViewController.swift
//  Instaflix
//
//  Created by Edgar Bermudez on 11/28/21.
//

import UIKit
import Parse
import AlamofireImage
import TMDBSwift

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var searchbar: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    var isSearchInputGiven = false
    
    var movies = [MovieMDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
        if isSearchInputGiven {
            print("inside of viewDidLoad, when searchInput = true")
            
            SearchMDB.movie(query: searchbar.text ?? "", language: "EN", page: 1, includeAdult: false, year: nil, primaryReleaseYear: nil) { data, movieArr in
                self.movies = movieArr!
                self.tableview.reloadData()
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
        
        if isSearchInputGiven {
            
            print("inside of viewWillAppear, when searchInput = true")
            SearchMDB.movie(query: searchbar.text ?? "", language: "EN", page: 1, includeAdult: false, year: nil, primaryReleaseYear: nil) { data, movieArr in
                self.movies = movieArr!
                self.tableview.reloadData()
            }
        }
    }
    
    
    
    @IBAction func searchButton(_ sender: Any) {
        isSearchInputGiven = true
        print("search button was pressed")
        
        SearchMDB.movie(query: searchbar.text ?? "", language: "EN", page: 1, includeAdult: false, year: nil, primaryReleaseYear: nil) { data, movieArr in
            self.movies = movieArr!
            print(movieArr!.count)
            self.tableview.reloadData()
        }
        
    }
    
    
    //table stuff below
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0;
        if isSearchInputGiven {
            print("inside of row counting, searchInput = true")
            
            print(movies.count)
            
            rows = movies.count
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        if isSearchInputGiven {
            print("inside of cell info, searchInput = true")
            
            let movie = movies[indexPath.row]
            cell.title.text = movie.title!
            cell.synopsis.text = movie.overview!
            
            if movie.poster_path != nil {
                let posterPath = movie.poster_path as String?
                let baseURL =  "https://image.tmdb.org/t/p/w185"
                let url = URL(string: baseURL + posterPath!)
                cell.posterImage?.af_setImage(withURL: url!)
            }
            /*
            let posterPath = movie.poster_path as String?
            let baseURL =  "https://image.tmdb.org/t/p/w185"
            let url = URL(string: baseURL + posterPath!)
            cell.posterImage?.af_setImage(withURL: url!)
             */
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieViewController {
            print("====> loading up the details....")
            let cell = sender as! UITableViewCell
            let indexPath = tableview.indexPath(for: cell)
            
            let movie = movies[indexPath!.row]
            
            let detailsViewController = segue.destination as! MovieViewController
            detailsViewController.movie = movie
        }
    }
    
    
    

}
