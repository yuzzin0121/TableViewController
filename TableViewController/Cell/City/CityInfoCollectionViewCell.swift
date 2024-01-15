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
    
    func changeTextColor(keyword: String?) {
        guard let keyword = keyword else { return }
        let cityNameText = cityNameLabel.text!
        let cityEnglishNameText = cityEnglishNameLabel.text!
        let cityExplainText = cityExplainLabel.text!
        
        let nameAttributeString = NSMutableAttributedString(string: cityNameText)
        let englishNameAttributeString = NSMutableAttributedString(string: cityEnglishNameText)
        let explainAttributeString = NSMutableAttributedString(string: cityExplainText)
        
        nameAttributeString.addAttribute(.foregroundColor, value: UIColor.red, range: (cityNameText as NSString).range(of: keyword))
        englishNameAttributeString.addAttribute(.foregroundColor, value: UIColor.red, range: (cityEnglishNameText as NSString).range(of: keyword))
        explainAttributeString.addAttribute(.foregroundColor, value: UIColor.red, range: (cityExplainText as NSString).range(of: keyword))
        
        cityNameLabel.attributedText = nameAttributeString
        cityEnglishNameLabel.attributedText = englishNameAttributeString
        cityExplainLabel.attributedText = explainAttributeString
    }
}
