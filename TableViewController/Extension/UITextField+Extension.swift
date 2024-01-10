//
//  UITextField+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation
import UIKit

extension UITextField {
    func designTextField(placeHolder: String) {
        self.backgroundColor = .systemGray6
        self.placeholder = placeHolder
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
}
