//
//  BookTextField.swift
//  Books
//
//  Created by Alessandro Musto on 3/15/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class BookTextField: UITextField {

    let inset: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
    }



    override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect
    {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
}
