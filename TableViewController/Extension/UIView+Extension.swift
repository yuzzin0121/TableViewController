//
//  UIView+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation
import UIKit

extension UIView {
    func designBackgroundView(cornerRadius: CGFloat = 0) {
        self.backgroundColor = .systemGray6
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
