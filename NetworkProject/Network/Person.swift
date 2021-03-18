//
// Person.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 03. 14.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

struct Person: Codable {
    let name: String
    let age: Int
    var dogs: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case dogs = "dogzzz"
    }
    
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        age = try container.decode(Int.self, forKey: .age)
//        dogs = try container.decode([String].self, forKey: .dogs)
//    }
}

struct PersonDogs: Decodable {
    var dogs: [String]
}

struct Dimensions: Decodable {
    let height: Int
    let weight: Int
}

struct CatOwner {
    var name: String
    var age: Int
    var cats: [String]
}
