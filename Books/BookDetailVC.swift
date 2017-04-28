//
//  BookDetailVC.swift
//
//
//  Created by Alessandro Musto on 3/14/17.
//
//

import UIKit

class BookDetailVC: UIViewController, BookViewDelegate {

    let store = BookDataStore.sharedInstance
    var book: Book!
    var bookView: BookView!



    override func viewDidLoad() {
        super.viewDidLoad()
        bookView = BookView(frame: view.frame)
        self.view = bookView
        bookView.delegate = self
        bookView.book = self.book

    }

    func onCheckout() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm a"
        let dateString = formatter.string(from: date)

        let alertVC = UIAlertController(title: "Would you like to checkout this book?", message: "", preferredStyle: .alert)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.store.checkoutBook(withID: self.book.id, atTime: dateString) {}
            self.navigationController!.popViewController(animated: true)

        }
        alertVC.addAction(yesAction)

        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
        }
        
        alertVC.addAction(noAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func onDelete() {
        let alertVC = UIAlertController(title: "\(book.title) has been deleted", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
            self.store.deleteBook(withID: self.book.id, completion: {})
            self.navigationController!.popViewController(animated: true)
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
}

