//
//  Sting.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    var trimmed: String {
        trimmingCharacters(in: .whitespaces)
    }
    
    // true if all characters are number digits
    var onlyNumbers: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
    // true if all characters are either characters from the alphaber or whitespaces
    var onlyCharacters: Bool {
        let letterCharacters = CharacterSet.letters.union(.whitespaces)
        let nonLetterCharacters = letterCharacters.inverted
        
        return rangeOfCharacter(from: nonLetterCharacters) == nil
    }
}
