//
//  MostRecentVC.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class MostRecentVC: UIViewController {

    private var mostRecentStoriesIDArray = [Int]()
    private var storyData = [[String: Any]]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RequestData.fetchStories(from: URL(string: Constants.MOST_RECENT.rawValue)!) { (arrayOfStories) in
            self.mostRecentStoriesIDArray = arrayOfStories as! [Int]
            
            for storyId in self.mostRecentStoriesIDArray {
                
                RequestData.fetchStories(from: URL(string: Constants.STORY.rawValue + "\(storyId).json")!, onCompletion: { (storyDetails) in
                    
                    guard (storyDetails as? [String: Any]) != nil else {
                        return
                    }
                    print("Story data: \(storyDetails as! [String: Any])")
                    self.storyData.append(storyDetails as! [String: Any])
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: - UITableViewDataSource
extension MostRecentVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "mostRecentTableViewCell", for: indexPath) as! MostViewedTableViewCell
        let _storyData = storyData[indexPath.row]
        tableCell.accessoryType = .none
        tableCell.titleLabel.text = (_storyData["title"] as! String)
        tableCell.likeCountLabel.text = "\(_storyData["score"]!)"
        
        if let commentsOnThePost = _storyData["kids"] as? [Int] {
            print("Comments count: \(_storyData["kids"] ?? 0)")
            tableCell.commentCountLabel.text = "\(commentsOnThePost.count)"
        } else {
            tableCell.commentCountLabel.text = "0"
        }
        
        return tableCell
    }
    
}


// MARK: - UITableViewDelegate
extension MostRecentVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Row at index: \(indexPath.row)")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



