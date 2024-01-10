//
//  ShoppingTableViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/5/24.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var textFieldBackgroundView: UIView!
    @IBOutlet weak var shopTodoTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var shoppingTodos: [ShoppingTodo] = [
        ShoppingTodo(isChecked: false, todo: "그립톡 구매하기", isBookmarked: false),
        ShoppingTodo(isChecked: false, todo: "사이다 구매", isBookmarked: false),
        ShoppingTodo(isChecked: false, todo: "아이패드 케이스 최저가 알아보기", isBookmarked: false),
        ShoppingTodo(isChecked: false, todo: "가디건 구매하기", isBookmarked: false),
        ShoppingTodo(isChecked: false, todo: "운동화 구매하기", isBookmarked: false),
        ShoppingTodo(isChecked: false, todo: "더현대 아이쇼핑하기", isBookmarked: false),
    ]
//    var shoppingTodoList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "가디건 구매하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldBackgroundView.designBackgroundView(cornerRadius: 8)
        shopTodoTextField.designTextField(placeHolder: "무엇을 구매하실 건가요?")
        addButton.designButton(title: "추가", cornerRadius: 10)
        
        tableView.rowHeight = 80
    }
    
    @IBAction func shopTodoTextFieldDidReturn(_ sender: UITextField) {
        let todo = shopTodoTextField.text!
        if todo == "" {   // 공백일 경우 추가 X
            return
        }
        let trimTodo = todo.trimmingCharacters(in: [" "])
        
        shoppingTodos.append(ShoppingTodo(isChecked: false, todo: trimTodo, isBookmarked: false))
        tableView.reloadData()
        shopTodoTextField.text = ""
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let todo = shopTodoTextField.text!
        if todo == "" {   // 공백일 경우 추가 X
            return
        }
        let trimTodo = todo.trimmingCharacters(in: [" "])
        shoppingTodos.append(ShoppingTodo(isChecked: false, todo: trimTodo, isBookmarked: false))
        tableView.reloadData()
        shopTodoTextField.text = ""
    }
    
    
    @objc
    func checkButtonClicked(sender: UIButton) {
        shoppingTodos[sender.tag].isChecked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    @objc
    func starButtonClicked(sender: UIButton) {
        shoppingTodos[sender.tag].isBookmarked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingTodos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier, for: indexPath) as! ShoppingTableViewCell // type casting
        
        cell.configureCell(item: shoppingTodos[indexPath.row])
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingTodos.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
