//
//  BooksAPI.swift
//  Books
//
//  Created by Alessandro Musto on 3/14/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class BooksAPI {


    class func getBooksJSON(completion: @escaping ([[String:Any]]) -> ()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books"
        Alamofire.request(urlString).responseJSON { response in
            if let JSON = response.result.value as? [[String:Any]] {
                completion(JSON)
            }

        }
    }

    class func checkOutBook(withID id: Int, atTime time: String, completion: @escaping () -> ()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books/\(id)"
        let parameters: Parameters = ["lastcheckedoutby" : "Sandro on \(time)",
            "lastcheckedout" : "true"]
        Alamofire.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { (response) in
            if let status = response.response   {
                if status.statusCode == 204 {
                    print(status.statusCode)
                    completion()
                }
            }

        }
    }

    class func addBook(withInfo dict: [String:String], completion: @escaping () -> ()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)

        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData


            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let status = response as? HTTPURLResponse {
                    if status.statusCode == 200 {
                        completion()
                    }
                }

            })
            task.resume()
        }
    }

    class func getBook(withID id: Int, completion: @escaping ([String:Any]) -> ()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books/\(id)"
        Alamofire.request(urlString).responseJSON { response in
            if let JSON = response.result.value as? [String:Any] {
                completion(JSON)
            }

        }
    }

    class func deleteBook(withID id: Int, completion: @escaping () -> ()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books/\(id)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let status = response as? HTTPURLResponse {
                    if status.statusCode == 200 {
                        completion()
                    } else {
                        print(error!)
                    }
                }
            })
            task.resume()
        }
    }
}
