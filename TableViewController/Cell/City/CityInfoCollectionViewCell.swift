//
//  CityInfoCollectionViewCell.swift
//  TableViewController
//
//  Created by 조유진 on 1/10/24.
//

import UIKit
import Kingfisher

class CityInfoCollectionViewCell: UICollectionViewCell, TableViewCellProtocol {
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityEnglishNameLabel: UILabel!
    @IBOutlet weak var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        cityNameLabel.design(font: .boldSystemFont(ofSize: 14))
        
        cityEnglishNameLabel.design(font: .boldSystemFont(ofSize: 14))
        
        cityExplainLabel.design(textColor: .lightGray)
    }
    
    override func layoutSubviews() {
        cityImageView.design(cornerRadius: cityImageView.frame.height / 2)
    }
    
    func configureCell(item: Any) {
        let cityInfo = item as! City
        
        cityImageView.kf.setImage(with: cityInfo.cityImageUrl, placeholder: UIImage(named: "sunrise"))
        cityNameLabel.text = cityInfo.city_name
        cityEnglishNameLabel.text = cityInfo.city_english_name
        cityExplainLabel.text = cityInfo.city_explain
    }
    
    // keyword에 해당하는 글자만 색깔 변경
    func changeTextColor(keyword: String?) {
        cityNameLabel.changeTextColor(keyword: keyword)
        cityEnglishNameLabel.changeTextColor(keyword: keyword)
        cityExplainLabel.changeTextColor(keyword: keyword)
    }
}
