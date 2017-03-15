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
  var titleLabel: UILabel!
  var authorLabel: UILabel!
  var publisherLabel: UILabel!
  var checkoutLabel: UILabel!
  var checkedByLabel: UILabel!
  var checkOutButton: UIButton!


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

      titleLabel = UILabel()
      titleLabel.font = UIFont(name: "HelveticaNeue", size: 23)
      authorLabel = UILabel()
      authorLabel.font = UIFont(name: "HelveticaNeue", size: 19)
      publisherLabel = UILabel()
      checkoutLabel = UILabel()
      checkedByLabel = UILabel()
      checkoutLabel.text = "Checked Out By:"
      titleLabel.text = book.title
      authorLabel.text = book.author
      publisherLabel.text = "Published By: \(book.publisher)"
      if book.lastCheckedOut == false {
        checkedByLabel.text = "book is currently available"
        checkOutButton.isEnabled = true
      } else {
        checkedByLabel.text = "\(book.lastCheckedOutBy)"
        checkOutButton.isEnabled = false

      }



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



  }

  func onCheckout(_ sender: UIButton) {

    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE, dd MMM yyyy hh:mm a"
    let dateString = formatter.string(from: date)

    store.checkoutBook(withID: book.id, atTime: dateString) {
      self.checkedByLabel.text = "Sandro on \(dateString)"
      self.checkOutButton.isEnabled = false
    }

    

  }


}
