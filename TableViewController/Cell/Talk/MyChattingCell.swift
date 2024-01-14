//
//  MyChattingCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class MyChattingCell: UITableViewCell, TableViewCellProtocol {
    static var identifier: String = "MyChattingCell"
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var myMessageLabel: UILabel!
    @IBOutlet weak var messageDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myMessageLabel.design(font: .systemFont(ofSize: 14), numberOfLines: 50)
        designBackground(messageBackground)
        messageDateLabel.design(textColor: .darkGray, font: .systemFont(ofSize: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designBackground(_ view: UIView) {
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureCell(item: Any) {
        let chat = item as! Chat
        myMessageLabel.text = chat.message
        messageDateLabel.text = chat.messageDateString
    }
}
