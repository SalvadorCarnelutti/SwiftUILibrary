//
//  SuggestionTextField.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import SwiftUI

struct SuggestionTextField: View {
    let placeholderText: String
    let footerText: String
    /* This is different from @State private var fieldBindString: String as this passes directly
     the bind instead of the current value passed
 */
    let fieldBindString: Binding<String>

    var body: some View {
        VStack {
            TextField(placeholderText, text: fieldBindString)
            Divider()
            HStack {
                Text(footerText)
                    .font(.footnote)
                    .foregroundColor(.charcoal)
                Spacer()
            }
        }
        .padding(.vertical, 8)
    }
}

struct SuggestionTextField_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionTextField(placeholderText: "Field name",
                            footerText: "Required field",
                            fieldBindString: .constant(""))
        .padding()
    }
}
