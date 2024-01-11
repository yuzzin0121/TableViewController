//
//  Travel.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import Foundation

struct Travel {
    let title: String
    let description: String?
    let travel_image: String?
    var travel_img_url: URL? {
        return URL(string: travel_image ?? "")
    }
    let grade: Double?
    let save: Int?
    let like: Bool?
    let ad: Bool
}
