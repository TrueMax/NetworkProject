//
// IndianTrains.swift
// NetworkProject
// 
// Created by Maxim Abakumov on 2021. 05. 11.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

// MARK: - IndianTrain
struct IndianTrain: Codable {
    let trainNum: Int
    let name, trainFrom, trainTo: String
    let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case trainNum = "train_num"
        case name
        case trainFrom = "train_from"
        case trainTo = "train_to"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: String
    let days: Days
    let toID: String
    let classes: [Class]
    let fromID, arriveTime, departTime: String
    
    enum CodingKeys: String, CodingKey {
        case id, days
        case toID = "to_id"
        case classes
        case fromID = "from_id"
        case arriveTime, departTime
    }
}

enum Class: String, Codable {
    case the1A = "1A"
    case the2A = "2A"
    case the3A = "3A"
}

// MARK: - Days
struct Days: Codable {
    let fri, mon, sat, sun, thu, tue, wed: String
    
    enum CodingKeys: String, CodingKey {
        case fri = "Fri"
        case mon = "Mon"
        case sat = "Sat"
        case sun = "Sun"
        case thu = "Thu"
        case tue = "Tue"
        case wed = "Wed"
    }
}
