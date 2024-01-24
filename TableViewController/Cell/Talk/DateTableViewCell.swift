//
//  DateTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/16/24.
//

import UIKit

class DateTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    @IBOutlet weak var dateBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateBackgroundView.layer.cornerRadius = 8
        dateBackgroundView.backgroundColor = UIColor(named: "textViewGray")
        dateLabel.design(textColor: .darkGray, font: .systemFont(ofSize: 12))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Any) {
        let dateString = item as! Chat
        dateLabel.text = dateString.divisionDateString
    }
}
