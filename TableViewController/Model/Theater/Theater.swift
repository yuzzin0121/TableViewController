//
//  Theater.swift
//  TableViewController
//
//  Created by 조유진 on 1/15/24.
//

import Foundation
import CoreLocation

enum TheaterName: String {
    case total
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


