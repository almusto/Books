//
//  BookView.swift
//  Books
//
//  Created by Alessandro Musto on 4/27/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

protocol BookViewDelegate: class {
    func onCheckout()
    func onDelete()
}


class BookView: UIView {

    var bookId: Int!
    var book: Book! {
        didSet {
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
    var titleLabel: UILabel!
    var authorLabel: UILabel!
    var publisherLabel: UILabel!
    var checkoutLabel: UILabel!
    var checkedByLabel: UILabel!
    var checkOutButton: UIButton!
    var deleteButton: UIButton!
    weak var delegate: BookViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        comonInit()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comonInit()
        setConstraints()
    }


    func comonInit() {

        self.backgroundColor = UIColor.white

        checkOutButton = UIButton(type: .custom)
        checkOutButton.setTitle("Checkout", for: .normal)
        checkOutButton.setTitleColor(UIColor.black, for: .normal)
        checkOutButton.layer.borderColor = UIColor.black.cgColor
        checkOutButton.layer.borderWidth = 2
        checkOutButton.layer.cornerRadius = 8
        checkOutButton.translatesAutoresizingMaskIntoConstraints = false
        checkOutButton.addTarget(self, action: #selector(onCheckout(_:)), for: .touchUpInside)
        self.addSubview(checkOutButton)

        deleteButton = UIButton(type: .custom)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.black, for: .normal)
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.cornerRadius = 8
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(onDelete(_:)), for: .touchUpInside)
        self.addSubview(deleteButton)

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
            self.addSubview(label!)
        }

    }

    func setConstraints() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        authorLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        publisherLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        publisherLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        publisherLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        checkoutLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 20).isActive = true
        checkoutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        checkoutLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        checkedByLabel.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: 5).isActive = true
        checkedByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        checkedByLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true

        checkOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkOutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        checkOutButton.topAnchor.constraint(equalTo: checkedByLabel.bottomAnchor, constant: 40).isActive = true
        checkOutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        deleteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        deleteButton.topAnchor.constraint(equalTo: checkOutButton.bottomAnchor, constant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }

    func onCheckout(_ sender: UIButton) {
        delegate?.onCheckout()
    }

    func onDelete(_ sender: UIButton) {
        delegate?.onDelete()
    }


}
