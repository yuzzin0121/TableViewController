//
//  ShoppingTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/5/24.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "ShoppingTableViewCell"
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var shopTodoLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    
    func configureCell(item: Any) {
        let shoppingTodo = item as! ShoppingTodo
        
        // 배경 디자인
        cellBackgroundView?.backgroundColor = .systemGray6
        cellBackgroundView?.clipsToBounds = true
        cellBackgroundView?.layer.cornerRadius = 8
        
        // 체크박스 이미지 설정
        let checkImage = !shoppingTodo.isChecked ? "checkmark.square" :"checkmark.square.fill"
        checkButton.setImage(UIImage(systemName: checkImage), for: .normal)
        
        checkButton.tintColor = .black
        shopTodoLabel.text = shoppingTodo.todo
        shopTodoLabel.font = .systemFont(ofSize: 14)
        
        let starImage = !shoppingTodo.isBookmarked ? "star" : "star.fill"
        starButton.setImage(UIImage(systemName: starImage), for: .normal)
        starButton.tintColor = .black
    }
    
}
