//
//  UIButton+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation
import UIKit

extension UIButton {
    func designButton(title: String, titleColor: UIColor = .black, cornerRadius: CGFloat = 0) {
        self.backgroundColor = .systemGray5
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
