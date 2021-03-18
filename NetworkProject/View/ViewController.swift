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
    
    private let viewModel = ViewModel()
    
    private lazy var control: UISegmentedControl = {
        let operations = ["upload", "download", "post", "dataTask"]
        let control = UISegmentedControl(items: operations)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .lightGray
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(sendRequest), for: .valueChanged)
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(control)
        NSLayoutConstraint.activate([
            control.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10)
        ])
    }
    
    @objc private func sendRequest() {
        switch control.selectedSegmentIndex {
        case 0:
            viewModel.uploadImage()
        case 1:
            viewModel.downloadContents()
        case 2:
            break
        case 3:
            viewModel.receiveData()
        default:
            break
        }
    }
}

