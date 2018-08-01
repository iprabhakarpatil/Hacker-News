//
//  TopRatedVC.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class TopRatedVC: UIViewController {
    
    var popularMovies = [[String: Any]]()
    var pageNumber = 1
    var totalPages = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.prefetchDataSource = self
        fetchPopularMovies()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchPopularMovies() {
        RequestData.fetchStories(from: URL(string: Constants.POPULAR_MOVIES_BASE_URL.rawValue+"\(pageNumber)"+Constants.TMDB_API_KEY.rawValue)!) { (popularMoviesArray) in
           
            guard let moviesObject = popularMoviesArray as? [String: Any] else {
                print("No Movie Object Found")
                return
            }
            
            self.totalPages = moviesObject["total_pages"] as! Int
            
            if let moviesList = moviesObject["results"] as? [[String: Any]] {
                if self.popularMovies.isEmpty {
                    self.popularMovies = moviesList
                } else {
                    for movie in moviesList {
                        self.popularMovies.append(movie)
                    }
                }
                
                if self.pageNumber < self.totalPages {
                   self.pageNumber += 1
                }
                
                print("Movies List: \(self.popularMovies)")
                DispatchQueue.main.async {
                     self.tableView.reloadData()
                }
            }
        }
    }


}


// MARK: - UITableViewDataSource
extension TopRatedVC: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieListTableViewCell
        
        if let movieDetailsForCurrentIndex = popularMovies[indexPath.row] as? [String: Any] {
            cell.movieTitleLabel.text = movieDetailsForCurrentIndex["title"] as? String
            cell.movieRatingLabel.text = "\(movieDetailsForCurrentIndex["vote_average"] ?? 0)/10"
            cell.movieReleasedDate.text = "\(describing: movieDetailsForCurrentIndex["release_date"] ?? 01/01/1900)"
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension TopRatedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


// MARK: - UITableViewDataSourcePrefetching
extension TopRatedVC: UITableViewDataSourcePrefetching {
 
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        fetchPopularMovies()
    }
    
}
