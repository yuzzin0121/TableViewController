//
//  UIButton+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation
import UIKit

extension UIButton {
    func designButton(title: String="", image: UIImage?=nil, titleColor: UIColor = .black, cornerRadius: CGFloat = 0) {
        self.backgroundColor = .systemGray5
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
  
}

extension UIButton.Configuration {
    static func locationStyle() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()

        config.baseBackgroundColor = .white
        config.baseForegroundColor = .systemBlue
        
        config.image = UIImage(systemName: "location.fill")
        config.imagePlacement = .all
        config.imagePadding = 12
        config.cornerStyle = .capsule
        
        return config
    }
}
