//
//  UIIamge.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/11/23.
//

import UIKit

extension UIImage {
    func isEqualToImage(_ image: UIImage) -> Bool {
        let data1 = self.pngData()
        let data2 = image.pngData()
        return data1 == data2
    }
    
    func isNotEqualToImage(_ image: UIImage) -> Bool {
        !isEqualToImage(image)
    }
    
    var isNonEmpty: Bool {
        isNotEqualToImage(UIImage())
    }
}
