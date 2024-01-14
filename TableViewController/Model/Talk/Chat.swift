//
//  Chat.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import Foundation

//채팅 화면에서 사용할 데이터 구조체
struct Chat {
    let user: User
    let date: String
    let message: String
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let convertDate = formatter.date(from: date ?? "2024-01-12 18:38")
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale(identifier:"ko_KR")
        
        return formatter.string(from: convertDate ?? Date())
       
    }
    
    var messageDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        let convertDate = formatter.date(from: date ?? "2024-01-12 18:38")
        formatter.dateFormat = "hh:mm a"
        formatter.locale = Locale(identifier:"ko_KR")
        
        return formatter.string(from: convertDate ?? Date())
    }
}
