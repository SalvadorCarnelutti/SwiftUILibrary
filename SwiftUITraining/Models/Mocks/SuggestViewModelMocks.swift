//
//  SuggestViewModelMocks.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/12/23.
//

extension SuggestViewModel {
    static func getMockedSuggestViewModel() -> SuggestViewModel {
        let vm = SuggestViewModel()
        vm.bookName = "Lupus"
        vm.bookAuthor = "Frederik Peeters"
        vm.bookYear = "2011"
        return vm
    }
}
