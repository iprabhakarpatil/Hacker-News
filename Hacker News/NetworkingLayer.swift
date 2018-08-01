//
//  NetworkingLayer.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import Foundation

class RequestData {
    
    class func fetchStories(from url: URL, onCompletion: @escaping (Any?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                print("error while fetching the data: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let fetchedData = data else {
                print("NO Data received for the specified URL")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: fetchedData, options: JSONSerialization.ReadingOptions.allowFragments)  else {
                
                print("Data error: \(fetchedData)")
                return
            }
            
            print("JSON is fetched successfully: \(String(describing: json))")
            if json != nil {
                onCompletion(json)
            }
            
            
        }
        task.resume()
        
    }
    
}
