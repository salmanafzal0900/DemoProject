//
//  ArrayExtension.swift
//  AWQAF UAE
//
//  Created by Mac on 28/11/2022.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


//MARK:- Usage
//if let item = attachmentViews[safe: 10] {
//           print(item)
//}
