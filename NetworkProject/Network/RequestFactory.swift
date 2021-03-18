//
// RequestFactory.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 18.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

protocol RequestFactory {
    
    static func makeRequest(
        with urlString: String,
        method: String?,
        body: Data?,
        headers: Dictionary<String, String>?
    ) -> URLRequest
}
