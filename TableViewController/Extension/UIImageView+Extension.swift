//
//  UIImageView+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import UIKit

extension UIImageView {
    func design(contentMode: UIView.ContentMode = .scaleAspectFill, cornerRadius: CGFloat = 8) {
        self.contentMode = contentMode
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
