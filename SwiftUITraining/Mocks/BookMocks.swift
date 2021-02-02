//
//  File.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

import Foundation
extension Book {
    static func getMockBook() -> Book {
        return Book(id: 123, author: "Diego", title: "El señor de los anillos", genre: "misterio", year: "1999", image: "", status: "")
    }
}
