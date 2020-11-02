//
//  Book.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import Foundation

struct Book: Codable, Equatable, Identifiable {
    var id: String
    var author: String
    var title: String
    var genre: String
    var publisher: String
    var year: String
    var imageUrl: String
}
