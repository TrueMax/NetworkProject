//
// ViewModel.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 18.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

class ViewModel {
    
    private enum Trains {
        static let trainUrlString = "https://trains.p.rapidapi.com/"
        static let trainHeaders = [
            "content-type": "application/json",
            "x-rapidapi-key": "83b49bb162mshaaddbd43205ca6bp1e8410jsn558ad047c75b",
            "x-rapidapi-host": "trains.p.rapidapi.com"
        ]
        static let trainRequest = TrainRequest(search: "Rajdhani")
    }
    
    private enum SampleData {
        static let dictionary: [String: Any] = [ "name": "Anna",
                                                 "age": 30,
                                                 "cats": ["Tom", "Sue"]
        ]
        
        static let person = Person(
            name: "Richard",
            age: 45,
            dogs: ["Jack", "Bobik"]
        )
    }
    
    private enum LocalServer {
        static let localUrl = "http://localhost:5000"
    }
    
//    func jsonSerialize() {
//
//        // JSONSerialization: Swift -> JSON
//        var data: Data?
//        if let json = try? NetworkService.toData(dictionary: SampleData.dictionary) {
//            print(String(data: json, encoding: .utf8)!)
//            data = json
//        }
//
//        // JSONSerialization: JSON -> Swift
//        if let data = data,
//           let dictionary = try? NetworkService.toObject(json: data) {
//            let catOwner = CatOwner(
//                name: dictionary["name"] as! String,
//                age: dictionary["age"] as! Int,
//                cats: dictionary["cats"] as! [String])
//            print(catOwner.age)
//        }
//    }
    
//    private func jsonEncodeDecodeSample() {
//
//        guard let json = try? JSONEncoder().encode(SampleData.person) else { fatalError() }
//
//        /// *формирование запроса...*
//        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/2")
//        var request = URLRequest(url: url!)
//        request.httpBody = json
//        /// *...создаем URLSessionDataTask*
//
//        // Decodable
//        if let object = try? JSONDecoder().decode(Person.self, from: json) {
//
//        }
//    }
    
//    func sendEncodedRequest() {
//
//        NetworkService.dataTaskRequest(
//            urlRequest: postRequest
//        ) { data in
//            if let data = data {
//            print(String(data: data, encoding: .utf8) ?? "empty data")
//
//            }
//        }
//    }
    
    // Uploading Image
    
    func uploadImage() {
        let image = UIImage(named: "bigImage")?.jpegData(compressionQuality: 1.0)
        
        let request = ViewModel.makeRequest(
            with: LocalServer.localUrl,
            method: "POST",
            body: image,
            headers: nil)
        
        NetworkService.uploadTaskRequest(
            urlRequest: request
        ) { string in
            print(string!)
        }
    }
    
    // DOWNLOAD CONTENTS FROM URL
    
    func downloadContents() {
        let url = URL(string: "https://www.rbc.ru")!
        
        NetworkService.downloadTask(
            url: url) { string in
            if let contents = string {
                // print(contents)
            }
        }
    }
    
    func receiveData() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "jsonplaceholder.typicode.com"
        urlComponents.path = "/todos/3"
        
//        let queryItems = [
//            "units": "metric",
//            "q": "Moscow",
//            "lang": "ru_RU"
//        ].map { URLQueryItem(name: $0, value: $1) }
//        urlComponents.queryItems = queryItems
        
        NetworkService.dataTask(url: urlComponents.url!) { string in
            if let text = string {
                print(text)
            }
        }
    }
    
    func fetchTrains() {
        var request = URLRequest(url: URL(string: Trains.trainUrlString)!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(Trains.trainRequest)
        request.allHTTPHeaderFields = Trains.trainHeaders
        
        NetworkService.dataTaskRequest(
            urlRequest: request) { data in
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "empty data")
            }
        }
    }
}

extension ViewModel: RequestFactory {
    
    static func makeRequest(
        with urlString: String,
        method: String?,
        body: Data?,
        headers: Dictionary<String, String>?
    ) -> URLRequest {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        if let method = method {
            request.httpMethod = method
        }
        if let body = body {
            request.httpBody = body
        }
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
    
        return request
    }
}
