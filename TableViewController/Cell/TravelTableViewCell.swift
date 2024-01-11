//
//  TravelTableViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit
import Kingfisher

class TravelTableViewCell: UITableViewCell, TableViewCellProtocol {
    static var identifier: String = "TravelTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var savedValueLabel: UILabel!
    @IBOutlet weak var travelImageView: UIImageView!
    
    @IBOutlet weak var heartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.design(font: .boldSystemFont(ofSize: 14), numberOfLines: 2)
        descriptionLabel.design(textColor: .darkGray, font: .systemFont(ofSize: 12), numberOfLines: 2)
        gradeLabel.design(textColor: .gray, font: .systemFont(ofSize: 10))
        saveLabel.design(text: "• 저장", textColor: .gray, font: .systemFont(ofSize: 10))
        savedValueLabel.design(textColor: .gray, font: .systemFont(ofSize: 10))
        travelImageView.contentMode = .scaleAspectFill
        heartButton.tintColor = .black
        saveLabel.isHidden = false
    }
    
    override func draw(_ rect: CGRect) {
        travelImageView.clipsToBounds = true
        travelImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Any) {
        let travel = item as! Travel
        titleLabel.text = travel.title
        if let description = travel.description {
            descriptionLabel.text = description
        }
        if let grade = travel.grade {
            gradeLabel.text = "\(grade)"
        }
        if let save = travel.save {
            saveLabel.isHidden = false
            savedValueLabel.text = "\(save.formatterStyle(.decimal)!)"
        } else {
            saveLabel.isHidden = true
        }
        
        
        travelImageView.kf.setImage(with: travel.travel_img_url, placeholder: UIImage(named: "sunrise"))
    }
}
