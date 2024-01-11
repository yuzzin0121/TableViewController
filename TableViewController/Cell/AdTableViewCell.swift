//
//  AdTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    static var identifier: String = "AdTableViewCell"
    @IBOutlet weak var adStringLabel: UILabel!
    @IBOutlet weak var adMarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        adStringLabel.design(font: .boldSystemFont(ofSize: 14))
        adMarkLabel.design(text: "AD", font: .boldSystemFont(ofSize: 12), numberOfLines: 2)
        adMarkLabel.backgroundColor = .white
        adMarkLabel.textAlignment = .center
        adMarkLabel.clipsToBounds = true
        adMarkLabel.layer.cornerRadius = 12
        contentView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: String, backgroundColor: UIColor = .systemPink) {
        let adString = item
        adStringLabel.text = adString
        contentView.backgroundColor = backgroundColor
    }
}
