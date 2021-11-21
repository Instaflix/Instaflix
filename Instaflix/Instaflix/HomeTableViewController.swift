//
//  HomeTableViewController.swift
//  Instaflix
//
//  Created by Ciara Morell on 11/14/21.
//

import UIKit
import Parse
import AlamofireImage

class HomeTableViewController: UITableViewController {
    
    var selectedMovieID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    //delete the button and keep this code and the segue?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieViewController {
            let vc = segue.destination as? MovieViewController
            vc?.movieID = selectedMovieID
        }
    }
    
    @IBAction func testMovieDisplay(_ sender: Any) {
        selectedMovieID = 550
        self.performSegue(withIdentifier: "homeToMovie", sender: self)
        
    }
    
}
