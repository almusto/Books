//
//  BookTableVC.swift
//  Books
//
//  Created by Alessandro Musto on 3/14/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class BookTableVC: UITableViewController {

    let store = BookDataStore.sharedInstance
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(BookCell.self, forCellReuseIdentifier: "bookCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.getBooks {
            DispatchQueue.main.async {
                self.books = self.store.books
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookCell
        cell.book = books[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = books[indexPath.row]
            books.remove(at: indexPath.row)
            store.deleteBook(withID: book.id, completion: { })
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = BookDetailVC()
        destVC.book = books[indexPath.row]
        navigationController?.pushViewController(destVC, animated: true)
    }

    func onAdd(_ sender: UIBarButtonItem) {
        let destVC = AddBookVC()
        navigationController?.pushViewController(destVC, animated: true)
    }

}
