//
//  BookDataStore.swift
//  Books
//
//  Created by Alessandro Musto on 3/14/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation

class BookDataStore {

  static let sharedInstance = BookDataStore()
  var books = [Book]()


  func getBooks(completion: @escaping () -> ()) {
    BooksAPI.getBooksJSON { (booksArray) in
      for book in booksArray {
        let newBook = Book(dict: book)
        self.books.append(newBook)
      }
      completion()
    }
  }

  func checkoutBook(withID id: Int, atTime time: String, completion: @escaping () -> ()) {
    BooksAPI.checkOutBook(withID: id, atTime: time) {
      completion()
    }
  }

  func addNewBook(withInfo dict: [String:String], completion: @escaping () -> ()) {
    BooksAPI.addBook(withInfo: dict) { 
      completion()
    }
  }
  

}
