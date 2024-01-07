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
    
    var shoppingTodoList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "가디건 구매하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designBackgroundView(textFieldBackgroundView)
        designTextField(shopTodoTextField, placeHolder: "무엇을 구매하실 건가요?")
        designButton(addButton, title: "추가")
    }
    
    @IBAction func shopTodoTextFieldDidReturn(_ sender: UITextField) {
        let todo = shopTodoTextField.text!
        if todo == "" {   // 공백일 경우 추가 X
            return
        }
        let trimTodo = todo.trimmingCharacters(in: [" "])
        
        shoppingTodoList.append(trimTodo)
        tableView.reloadData()
        shopTodoTextField.text = ""
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let todo = shopTodoTextField.text!
        if todo == "" {   // 공백일 경우 추가 X
            return
        }
        let trimTodo = todo.trimmingCharacters(in: [" "])
        shoppingTodoList.append(trimTodo)
        tableView.reloadData()
        shopTodoTextField.text = ""
    }
    
    func designBackgroundView(_ view: UIView) {
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
    }
    
    func designTextField(_ textField: UITextField, placeHolder: String) {
        textField.backgroundColor = .systemGray6
        textField.placeholder = placeHolder
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
    }
    
    func designButton(_ button: UIButton, title: String) {
        button.backgroundColor = .systemGray5
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingTodoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.cellBackgroundView?.backgroundColor = .systemGray6
        cell.cellBackgroundView?.clipsToBounds = true
        cell.cellBackgroundView?.layer.cornerRadius = 8
        cell.checkButton.setImage(UIImage(named: "checkBox"), for: .normal)
        cell.checkButton.tintColor = .black
        cell.shopTodoLabel.text = shoppingTodoList[indexPath.row]
        cell.shopTodoLabel.font = .systemFont(ofSize: 14)
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.starButton.tintColor = .black
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
