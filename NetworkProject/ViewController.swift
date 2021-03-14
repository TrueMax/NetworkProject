//
// ViewController.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 10.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://jsonplaceholder.typicode.com/todos/186"
        NetworkService.dataTaskRequest(url: URL(string: urlString)!) { string in
            if let result = string {
                print(result)
            }
        }
    }


}

