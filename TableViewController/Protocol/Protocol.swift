//
//  Protocol.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    func setBackground() {
        backgroundColor = .black
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}


extension UIViewController: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
