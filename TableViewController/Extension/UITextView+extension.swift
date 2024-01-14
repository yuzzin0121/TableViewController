//
//  UITextView+extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import Foundation
import UIKit

extension UITextView {
    func numberOfLine() -> Int {
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
//        print("\(estimatedSize.height), \(self.font!.lineHeight + 10)")
//        print(Int(estimatedSize.height / (self.font!.lineHeight + 10)))
        return Int(estimatedSize.height / (self.font!.lineHeight + 10))
    }
}
