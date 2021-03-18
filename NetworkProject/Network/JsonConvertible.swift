//
// JsonConvertible.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 18.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

protocol JsonConvertible {
    static func toObject(json: Data) throws -> Dictionary<String, Any>?
    static func toData(dictionary: Dictionary<String, Any>) throws -> Data
}
