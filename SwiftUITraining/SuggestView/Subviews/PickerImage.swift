//
//  PickerImage.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/12/23.
//

import SwiftUI

struct PickerImage: View {
    let bookImage: UIImage
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.babyBlue)
                .shadow(radius: 1.5)
            Image(systemName: "plus.circle")
                .foregroundColor(.white)
                .font(.system(size: 48.0, weight: .medium))
            Image(uiImage: bookImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
        .frame(width: 94, height: 94)
    }
}


struct PickerImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PickerImage(bookImage: UIImage())
                .padding(.vertical)
            PickerImage(bookImage: UIImage(systemName: "book.closed.fill")!)
        }
    }
}
