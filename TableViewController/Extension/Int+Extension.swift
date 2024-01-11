//
//  Int+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import Foundation

extension Int {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = numberStyle
        return numberFommater.string(for: self)
    }
}
