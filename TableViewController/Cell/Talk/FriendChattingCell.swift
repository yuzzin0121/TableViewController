//
//  FriendChattingCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class FriendChattingCell: UITableViewCell, TableViewCellProtocol {
    
    @IBOutlet weak var friendProfileImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var friendMessageLabel: UILabel!
    @IBOutlet weak var messageDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        friendNameLabel.design(font: .systemFont(ofSize: 12))
        friendMessageLabel.design(font: .systemFont(ofSize: 14), numberOfLines: 50)
        designBackground(messageBackgroundView)
        messageDateLabel.design(textColor: .darkGray, font: .systemFont(ofSize: 10))
    }
    
    override func draw(_ rect: CGRect) {
        friendProfileImageView.contentMode = .scaleAspectFill
        friendProfileImageView.clipsToBounds = true
        friendProfileImageView.layer.cornerRadius = friendProfileImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func designBackground(_ view: UIView) {
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureCell(item: Any) {
        let chat = item as! Chat
        friendProfileImageView.image = UIImage(named: chat.user!.profileImage)
        friendNameLabel.text = chat.user!.rawValue
        friendMessageLabel.text = chat.message
        messageDateLabel.text = chat.messageDateString
    }
}
