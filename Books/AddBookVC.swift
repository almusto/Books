//
//  AddBookVC.swift
//  Books
//
//  Created by Alessandro Musto on 3/15/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class AddBookVC: UIViewController {


    let store = BookDataStore.sharedInstance
    var titleTextField: BookTextField!
    var authorTextField: BookTextField!
    var publisherTextField: BookTextField!
    var submitButton: UIButton!



    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "Add Book"

        submitButton = UIButton(type: .custom)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.black, for: .normal)
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 8
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(onSubmit(_:)), for: .touchUpInside)
        view.addSubview(submitButton)

        setUpTextFeilds()
        addConstraints()



    }

    func addConstraints() {
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -10).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        authorTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10).isActive = true
        authorTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -10).isActive = true
        authorTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        authorTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        publisherTextField.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: 10).isActive = true
        publisherTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -10).isActive = true
        publisherTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        publisherTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        submitButton.topAnchor.constraint(equalTo: publisherTextField.bottomAnchor, constant: 20).isActive = true
        submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -100).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }


    func onSubmit(_ sender: UIButton) {
        let areTextFieldsValid: Bool = (titleTextField.text != nil && titleTextField.text != "Book Title") && (authorTextField.text != nil && authorTextField.text != "Author") && (publisherTextField.text != nil && publisherTextField.text != "Publisher")

        if areTextFieldsValid {
            guard let titleText = titleTextField.text, let authorText = authorTextField.text, let publisherText = publisherTextField.text else { return}
            let successAlertVC = UIAlertController(title: "Book has been added", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: { (action) in
                let dict = ["title": titleText,
                            "author" : authorText,
                            "publisher" : publisherText,
                            "url" : ""]
                self.store.addNewBook(withInfo: dict, completion: {

                })
                self.titleTextField.text = "Book Title"
                self.titleTextField.textColor = UIColor.lightGray
                self.authorTextField.text = "Author"
                self.authorTextField.textColor = UIColor.lightGray
                self.publisherTextField.text = "Publisher"
                self.publisherTextField.textColor = UIColor.lightGray
                self.dismiss(animated: true, completion: nil)

            })

            successAlertVC.addAction(okAction)
            self.present(successAlertVC, animated: true, completion: nil)
        } else {
            let failureAlertVC = UIAlertController(title: "invalid entries", message: "fix your shit", preferredStyle: .alert)
            let failureAction = UIAlertAction(title: "ok", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            failureAlertVC.addAction(failureAction)
            self.present(failureAlertVC, animated: true, completion: nil)
        }
    }
}

//MARK: TextFieldDelegate

extension AddBookVC: UITextFieldDelegate {


    func setUpTextFeilds() {

        let frame = CGRect()

        titleTextField = BookTextField(frame: frame)
        titleTextField.text = "Book Title"
        authorTextField = BookTextField(frame: frame)
        authorTextField.text = "Author"
        publisherTextField = BookTextField(frame: frame)
        publisherTextField.text = "Publisher"

        let textFields = [titleTextField, authorTextField, publisherTextField]

        for textField in textFields {
            textField?.textColor = UIColor.lightGray
            textField?.delegate = self
            textField?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(textField!)
        }
    }


    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)! {
            textField.textColor = UIColor.lightGray
            switch textField {
            case titleTextField:
                textField.text = "Book Title"
            case authorTextField:
                textField.text = "Author"
            case publisherTextField:
                textField.text = "Publisher"
            default:
                textField.text = ""
                
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
