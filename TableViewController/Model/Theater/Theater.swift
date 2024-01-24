//
//  Theater.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import Foundation
import CoreLocation

enum TheaterName: String, CaseIterable {
    case total = "전체보기"
    case Lotte = "롯데시네마"
    case Mega = "메가박스"
    case CGV = "CGV"
}

struct Theater {
    let type: String
    let location: String
    let latitude: Double
    let longitude: Double
}


