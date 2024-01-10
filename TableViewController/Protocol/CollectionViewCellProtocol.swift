//
//  CityCollectionViewCellProtocol.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation

protocol CollectionViewCellProtocol {
    static var identifier: String { get set }
    func configureCell(item: Any)
    
}
