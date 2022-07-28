//
//  PostData.swift
//  Hacker News Reader
//
//  Created by user220431 on 7/28/22.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}


struct Post: Identifiable, Decodable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let url: String?
    let points: Int
}
