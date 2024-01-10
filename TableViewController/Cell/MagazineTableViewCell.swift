//
//  MagazineTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/8/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell, TableViewCellProtocol{
    static var identifier: String = "MagazineTableViewCell"
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func configureCell(item: Any) {
        let magazine = item as! Magazine
        
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 10
        
        titleLabel.text = magazine.title
        subtitleLabel.text = magazine.subtitle
        photoImageView.kf.setImage(with: magazine.imageUrl, placeholder: UIImage(named: "sunrise"))
        
        dateLabel.text = magazine.dateString
    }
}
