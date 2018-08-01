//
//  ViewController.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class MostViewedVC: UIViewController {
    
    private var mostViewedStoriesIDArray = [Int]()
    private var storyData = [[String: Any]]()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(MostViewedVC.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.orange
        return refreshControl
    }()
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(refreshControl)
        fetchMostViewedStories()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func fetchMostViewedStories() {
        
        RequestData.fetchStories(from: URL(string: Constants.MOST_VIEWED.rawValue)!) { (arrayOfStories) in
            self.mostViewedStoriesIDArray = arrayOfStories as! [Int]
            
            for storyId in self.mostViewedStoriesIDArray {
                
                RequestData.fetchStories(from: URL(string: Constants.STORY.rawValue + "\(storyId).json")!, onCompletion: { (storyDetails) in
                    print("Story data: \(storyDetails as! [String: Any])")
                    self.storyData.append(storyDetails as! [String: Any])
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                })
            }
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        fetchMostViewedStories()
    }
    
}


// MARK: - UITableViewDataSource
extension MostViewedVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "mostViewedTableViewCell", for: indexPath) as! MostViewedTableViewCell
        let _storyData = storyData[indexPath.row]
        tableCell.accessoryType = .none
        tableCell.titleLabel.text = (_storyData["title"] as! String)
        tableCell.likeCountLabel.text = "\(_storyData["score"]!)"
        
        if let commentsOnThePost = _storyData["kids"] as? [Int] {
            print("Comments count: \(_storyData["kids"] ?? 0)")
            tableCell.commentCountLabel.text = "\(commentsOnThePost.count)"
            tableCell.accessoryType = .disclosureIndicator
        } else {
            tableCell.commentCountLabel.text = "0"
        }
        
        return tableCell
    }
    
}


// MARK: - UITableViewDelegate
extension MostViewedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row at index: \(indexPath.row)")
        let _storyData = storyData[indexPath.row]
        if let commentIDArray = _storyData["kids"] as? [Int] {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewCommentsVC = storyBoard.instantiateViewController(withIdentifier: "viewComments") as! ViewCommentsVC
            viewCommentsVC.commentIDsArray = commentIDArray
            self.navigationController?.pushViewController(viewCommentsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}

