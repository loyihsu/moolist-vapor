//
//  Book.swift
//
//  Created by Yu-Sung Loyi Hsu on 27/08/2021.
//

import Foundation

struct Book {
    var title: String
    var author: String
}

struct Booklist: Codable {
    var books: [String]
}
