//
//  CityInfoCollectionViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/10/24.
//

import UIKit
import Kingfisher

class CityInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityEnglishNameLabel: UILabel!
    @IBOutlet weak var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
        cityImageView.contentMode = .scaleAspectFill
        cityNameLabel.font = .boldSystemFont(ofSize: 14)
        cityEnglishNameLabel.font = .boldSystemFont(ofSize: 14)
        cityExplainLabel.textColor = .lightGray
    }
    
    override func layoutSubviews() {
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
    }
    
    func setData(cityInfo: City) {
        cityImageView.kf.setImage(with: cityInfo.cityImageUrl, placeholder: UIImage(named: "sunrise"))
        cityNameLabel.text = cityInfo.city_name
        cityEnglishNameLabel.text = cityInfo.city_english_name
        cityExplainLabel.text = cityInfo.city_explain
    }
}
