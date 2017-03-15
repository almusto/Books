//
//  Book.swift
//  Books
//
//  Created by Alessandro Musto on 3/14/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation

class Book {
  let author: String
  let id: Int
  let lastCheckedOut: Bool
  let lastCheckedOutBy: String
  let publisher: String
  let title: String
  let url: String

  init(dict: [String: Any]) {
    author = dict["author"] as? String ?? ""
    id = dict["id"] as? Int ?? 0
    publisher = dict["publisher"] as? String ?? ""
    title = dict["title"] as? String ?? ""
    url = dict["url"] as? String ?? ""
    lastCheckedOutBy = dict["lastcheckedoutby"] as? String ?? ""
    lastCheckedOut = dict["lastcheckedout"] as? Bool ?? false
  }

}
