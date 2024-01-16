//
//  UILabel+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import Foundation
import UIKit

extension UILabel {
    func design(text: String="", textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 14), numberOfLines: Int=1) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    // keyword에 해당하는 글자만 색깔 변경
    func changeTextColor(keyword: String?, color: UIColor = .red) {
        guard let keyword = keyword else { return }
        
        let attributeString = NSMutableAttributedString(string: self.text!)
        attributeString.addAttribute(.foregroundColor, value: color, range: (self.text! as NSString).range(of: keyword))
        self.attributedText = attributeString
    }
}
