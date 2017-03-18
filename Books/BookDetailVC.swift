//
//  BookDetailVC.swift
//  
//
//  Created by Alessandro Musto on 3/14/17.
//
//

import UIKit

class BookDetailVC: UIViewController {


  let store = BookDataStore.sharedInstance

  var book: Book!
  var bookId: Int!
  var titleLabel: UILabel!
  var authorLabel: UILabel!
  var publisherLabel: UILabel!
  var checkoutLabel: UILabel!
  var checkedByLabel: UILabel!
  var checkOutButton: UIButton!
  var deleteButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = UIColor.white

      checkOutButton = UIButton(type: .custom)
      checkOutButton.setTitle("Checkout", for: .normal)
      checkOutButton.setTitleColor(UIColor.black, for: .normal)
      checkOutButton.layer.borderColor = UIColor.black.cgColor
      checkOutButton.layer.borderWidth = 2
      checkOutButton.layer.cornerRadius = 8
      checkOutButton.translatesAutoresizingMaskIntoConstraints = false
      checkOutButton.addTarget(self, action: #selector(onCheckout(_:)), for: .touchUpInside)
      view.addSubview(checkOutButton)

      deleteButton = UIButton(type: .custom)
      deleteButton.setTitle("Delete", for: .normal)
      deleteButton.setTitleColor(UIColor.black, for: .normal)
      deleteButton.layer.borderColor = UIColor.black.cgColor
      deleteButton.layer.borderWidth = 2
      deleteButton.layer.cornerRadius = 8
      deleteButton.translatesAutoresizingMaskIntoConstraints = false
      deleteButton.addTarget(self, action: #selector(onDelete(_:)), for: .touchUpInside)
      view.addSubview(deleteButton)

      titleLabel = UILabel()
      titleLabel.font = UIFont(name: "HelveticaNeue", size: 23)
      authorLabel = UILabel()
      authorLabel.font = UIFont(name: "HelveticaNeue", size: 19)
      publisherLabel = UILabel()
      checkoutLabel = UILabel()
      checkedByLabel = UILabel()
      checkoutLabel.text = "Checked Out By:"





      let labels = [titleLabel, authorLabel, publisherLabel, checkoutLabel, checkedByLabel]

      for label in labels {
        label?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label!)
      }

      setConstraints()



    }


  func setConstraints() {

    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    authorLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    publisherLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
    publisherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    publisherLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    checkoutLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20).isActive = true
    checkoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    checkoutLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    checkedByLabel.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: 5).isActive = true
    checkedByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    checkedByLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

    checkOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    checkOutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    checkOutButton.topAnchor.constraint(equalTo: checkedByLabel.bottomAnchor, constant: 40).isActive = true
    checkOutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    deleteButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    deleteButton.topAnchor.constraint(equalTo: checkOutButton.bottomAnchor, constant: 40).isActive = true
    deleteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true



  }


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getBook()

  }

  func getBook() {
    store.getBook(withID: bookId) {
      self.book = self.store.book
      self.publisherLabel.text = "Published By: \(self.book.publisher)"
      self.titleLabel.text = self.book.title
      self.authorLabel.text = self.book.author
      if self.book.lastCheckedOut == false {
        self.checkedByLabel.text = "book is currently available"
        self.checkOutButton.isEnabled = true
      } else {
        self.checkedByLabel.text = "\(self.book.lastCheckedOutBy)"
        self.checkOutButton.isEnabled = false

      }

    }
  }

  func onCheckout(_ sender: UIButton) {

    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MMM yyyy hh:mm a"
    let dateString = formatter.string(from: date)

    let alertVC = UIAlertController(title: "Would you like to checkout this book?", message: "", preferredStyle: .alert)

    let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
      self.store.checkoutBook(withID: self.book.id, atTime: dateString) {
        self.checkedByLabel.text = "Sandro on \(dateString)"
        self.checkOutButton.isEnabled = false
      }
    }
    alertVC.addAction(yesAction)

    let noAction = UIAlertAction(title: "No", style: .default) { (action) in
    }

    alertVC.addAction(noAction)

    self.present(alertVC, animated: true, completion: nil)


  }

  func onDelete(_ sender: UIButton) {
    let alertVC = UIAlertController(title: "\(book.title) has been deleted", message: "", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
      self.store.deleteBook(withID: self.book.id, completion: {})
      self.navigationController!.popViewController(animated: true)
    }
    alertVC.addAction(okAction)
    self.present(alertVC, animated: true, completion: nil)

  }


}

