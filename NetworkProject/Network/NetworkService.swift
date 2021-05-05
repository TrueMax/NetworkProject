//
// NetworkService.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 10.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

class SessionDelegate: NSObject, URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let ratio = round(Float(bytesSent) / Float(totalBytesExpectedToSend) * 100)
        print("Upload progress: \(ratio) %")
    }
}

class SessionDownloadDelegate: NSObject, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("isFinished downloading")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("written: \(totalBytesWritten)")
        print("expected: \(totalBytesExpectedToWrite)")
//        print("Download progress: \(progress) %")
    }
    
    
}

struct NetworkService {
    
    static var applicationConfiguration: AppConfiguration?
    
    // 1.
    private static let sharedSession = URLSession.shared
    
    // 2.
    private static var simpleSession: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        return URLSession(configuration: configuration)
    }
    
    private static var defaultSession: URLSession {
        return URLSession(
            configuration: .default,
            delegate: SessionDelegate(),
            delegateQueue: OperationQueue.main)
    }
    
    static func dataTask(
        url: URL,
        completion: @escaping (String?) -> Void
    ) {
        let task = sharedSession.dataTask(
            with: url
        ) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            print(httpResponse.statusCode)
            print(httpResponse.allHeaderFields as! [String: Any])
            
            if let data = data {
                completion(String(data: data, encoding: .utf8))
            }
        }
        
        task.resume()
    }
    
    static func dataTaskRequest(
        urlRequest: URLRequest,
        completion: @escaping (Data?) -> Void
    ) {
        
        let task = sharedSession.dataTask(
            with: urlRequest
        ) { data, response, error in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse  {
                print(httpResponse.statusCode)
            }
            
            completion(data)
        }
        task.resume()
    }
    
    // UPLOAD TASK
    
    static func uploadTaskRequest(
        urlRequest: URLRequest,
        completion: @escaping (String?) -> Void
    ) {
        let task = defaultSession.uploadTask(
            with: urlRequest,
            from: urlRequest.httpBody) { data, response, error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse  {
                print(httpResponse.statusCode)
            }
            
            if let string = data {
                completion(String(data: string, encoding: .utf8))
            }
        }
        task.resume()
    }
    
    // DOWNLOAD TASK
    
    static func downloadTask(
        url: URL,
        completion: @escaping (String?) -> Void
    ) {
        let request = URLRequest(url: url)
        let dTask = defaultSession.downloadTask(with: request)
        
//        let task = defaultSession.downloadTask(with: url) { localURL, urlResponse, error in
//            if let localURL = localURL {
//                completion(try? String(contentsOf: localURL))
//            }
//        }
        
        dTask.resume()
    }
}
 
extension NetworkService: JsonConvertible {
    
    static func toObject(json: Data) throws -> Dictionary<String, Any>? {
        return try JSONSerialization.jsonObject(
            with: json,
            options: .mutableContainers
        ) as? [String: Any]
    }
    
    static func toData(dictionary: Dictionary<String, Any>) throws -> Data {
        return try JSONSerialization.data(
            withJSONObject: dictionary,
            options: .fragmentsAllowed
        )
    }
}
