//
//  FourUserTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/14/24.
//

import UIKit

class FourUserTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    @IBOutlet weak var user1ImageView: UIImageView!
    @IBOutlet weak var user2ImageView: UIImageView!
    @IBOutlet weak var user3ImageView: UIImageView!
    @IBOutlet weak var user4ImageView: UIImageView!
    @IBOutlet weak var chatRoomNameLabel: UILabel!
    @IBOutlet weak var recentMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        [user1ImageView,user2ImageView,user3ImageView,user4ImageView].forEach {
            $0?.contentMode = .scaleAspectFill
        }
        chatRoomNameLabel.design(font: .boldSystemFont(ofSize: 14))
        recentMessageLabel.design(textColor: .gray, font: .systemFont(ofSize: 12))
        dateLabel.design(textColor: .lightGray, font: .systemFont(ofSize: 10))
    }
    
    override func draw(_ rect: CGRect) {
        [user1ImageView,user2ImageView,user3ImageView,user4ImageView].forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.height / 2
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Any) {
        let chatRoom = item as! ChatRoom
        let imageViews: [UIImageView] = [user1ImageView,user2ImageView,user3ImageView,user4ImageView]
        
        for index in 0...3 {
            imageViews[index].image = UIImage(named: chatRoom.chatroomImage[index])
        }
     
        chatRoomNameLabel.text = chatRoom.chatroomName
        recentMessageLabel.text = chatRoom.chatList.last?.message
        dateLabel.text = chatRoom.chatList.last?.dateString
    }
    
}
