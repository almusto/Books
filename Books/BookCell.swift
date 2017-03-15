//
//  BookCell.swift
//  Books
//
//  Created by Alessandro Musto on 3/14/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {


  var titleLabel: UILabel!
  var book: Book! {
    didSet {
      self.titleLabel.text = book.title

    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()



  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    commonInit()

  }


  func commonInit() {

    titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

  }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
