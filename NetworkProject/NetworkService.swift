//
// NetworkService.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 10.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

enum NetworkService {
    
    static let session = URLSession.shared
    
    static func dataTask(
        url: URL,
        completion: @escaping (String?) -> Void
    ) {
        let task = session.dataTask(
            with: url
        ) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
    
    static func dataTaskRequest(
        url: URL,
        completion: @escaping (String?) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(
            with: request
        ) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse  {
                print(httpResponse.statusCode)
            }
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
}
