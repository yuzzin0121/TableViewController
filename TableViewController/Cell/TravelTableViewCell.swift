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
    @IBOutlet weak var savedValueLabel: UILabel!
    @IBOutlet weak var travelImageView: UIImageView!
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet var starImageViews: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.design(font: .boldSystemFont(ofSize: 14), numberOfLines: 2)
        descriptionLabel.design(textColor: .darkGray, font: .systemFont(ofSize: 12), numberOfLines: 2)
        gradeLabel.design(textColor: .gray, font: .systemFont(ofSize: 10))
        savedValueLabel.design(textColor: .gray, font: .systemFont(ofSize: 10))
        travelImageView.contentMode = .scaleAspectFill
        heartButton.tintColor = .black
        
        for star in starImageViews {
            star.contentMode = .scaleAspectFit
            star.image = UIImage(systemName: "star")
            star.tintColor = .yellow
            star.isHidden = true
        }
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
            fillStar(grade: grade)
        }
        
        
        
        if let save = travel.save {
            savedValueLabel.text = "• 저장 \(save.formatterStyle(.decimal)!)"
        }
        
        travelImageView.kf.setImage(with: travel.travel_img_url, placeholder: UIImage(named: "sunrise"))
    }
    
    func fillStar(grade: Double) {
        let fillStarCount: Int = Int(grade / 1)
        let halfStarValue = grade - Double(fillStarCount)
        
        let halfImage: UIImage?
        if halfStarValue < 0.5 {
            halfImage = nil
        } else {
            halfImage = UIImage(systemName: "star.leadinghalf.filled")
        }
        
        for index in 0...fillStarCount - 1 {
            starImageViews[index].isHidden = false
            starImageViews[index].image = UIImage(systemName: "star.fill")
        }
        
        if let halfImage {
            starImageViews[fillStarCount].isHidden = false
            starImageViews[fillStarCount].image = halfImage
        }
    }
}
