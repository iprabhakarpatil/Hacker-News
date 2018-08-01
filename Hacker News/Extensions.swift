//
//  Extensions.swift
//  Hacker News
//
//  Created by prabhakar patil on 02/08/18.
//  Copyright © 2018 self. All rights reserved.
//

import Foundation


// MARK: - An extension to convert the HTML text to the swift string readble type.
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
