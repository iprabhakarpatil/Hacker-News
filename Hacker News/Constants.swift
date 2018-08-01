//
//  Constants.swift
//  Hacker News
//
//  Created by prabhakar patil on 28/07/18.
//  Copyright © 2018 self. All rights reserved.
//

import Foundation

enum Constants: String {
    
    //MARK: - URLS
    case MOST_VIEWED = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
    case MOST_RECENT = "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty"
    case TOP_RATED = "https://hacker-news.firebaseio.com/v0/beststories.json?print=pretty"
    case STORY = "https://hacker-news.firebaseio.com/v0/item/"
    case POPULAR_MOVIES_BASE_URL = "https://api.themoviedb.org/3/movie/popular?page="
    case TMDB_API_KEY = "&language=en-US&api_key=42c097405808bef87cfc72e18bb26584"
}
