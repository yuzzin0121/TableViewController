//
//  TableViewCellProtocol.swift
//  TableViewController
//
//  Created by 조유진 on 1/11/24.
//

import Foundation

protocol TableViewCellProtocol {
    static var identifier: String { get set }// 변수에서 값을 세팅할건지 아니면 가져올건지 설정할 수 있음 get, set
    
    func configureCell(item: Any) 
}
