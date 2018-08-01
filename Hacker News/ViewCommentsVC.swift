//
//  ViewCommentsVC.swift
//  Hacker News
//
//  Created by prabhakar patil on 30/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import UIKit

class ViewCommentsVC: UIViewController {

    @IBOutlet private var tableView: UITableView!
    var commentIDsArray = [Int]()
    var comments = [[String: Any]]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchComments()
        
    }

  
    private func fetchComments() {
        
        for commentId in commentIDsArray {
            
            RequestData.fetchStories(from: URL(string: Constants.STORY.rawValue + "\(commentId).json")!, onCompletion: { (comment) in
                print("Comment: \(comment as! [String: Any])")
                let commentDetails = comment as? [String: Any]
                if let isCommentDeleted = commentDetails!["deleted"] as? Int {
                    print("Comment was deleted\(isCommentDeleted)")
                } else {
                    self.comments.append(comment as! [String: Any])
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }

}


extension ViewCommentsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "viewCommentCell", for: indexPath)
        let comment = comments[indexPath.row]
        commentCell.textLabel?.text = "\(comment["text"] ?? "")".htmlToString
        commentCell.detailTextLabel?.text = "By: \(comment["by"] as! String)"
        return commentCell
    }
}
