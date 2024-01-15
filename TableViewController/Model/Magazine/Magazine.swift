//
//  Magazine.swift
//  TableViewController
//
//  Created by 조유진 on 1/8/24.
//

import Foundation

struct Magazine {
    let title: String
    let subtitle: String
    let photo_image: String
    var imageUrl: URL {
        return URL(string: photo_image)!
    }
    let date: String
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        let convertDate = formatter.date(from: date)
        formatter.dateFormat = "yy년 MM월 dd일"
        formatter.locale = Locale(identifier:"ko_KR")
        
        return formatter.string(from: convertDate!)
    }
    let link: String
}
