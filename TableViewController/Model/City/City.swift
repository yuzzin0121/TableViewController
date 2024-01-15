//
//  City.swift
//  TableViewController
//
//  Created by 조유진 on 1/10/24.
//

import Foundation

struct City {
    let city_name: String
    let city_english_name: String
    let city_explain: String
    let city_image: String
    var cityImageUrl: URL {
        URL(string: city_image)!
    }
    let domestic_travel: Bool
}
