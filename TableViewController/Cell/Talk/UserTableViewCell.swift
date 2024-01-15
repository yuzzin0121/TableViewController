//
//  UserTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class UserTableViewCell: UITableViewCell, TableViewCellProtocol {
 
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var recentMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userProfileImageView.contentMode = .scaleAspectFill
        userNameLabel.design(font: .boldSystemFont(ofSize: 14))
        recentMessageLabel.design(textColor: .gray, font: .systemFont(ofSize: 12))
        dateLabel.design(textColor: .lightGray, font: .systemFont(ofSize: 10))
    }
    
    override func draw(_ rect: CGRect) {
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Any) {
        let chatRoom = item as! ChatRoom
        userProfileImageView.image = UIImage(named: chatRoom.chatroomImage[0])
        userNameLabel.text = chatRoom.chatroomName
        recentMessageLabel.text = chatRoom.chatList.last?.message
        dateLabel.text = chatRoom.chatList.last?.dateString
    }
}
