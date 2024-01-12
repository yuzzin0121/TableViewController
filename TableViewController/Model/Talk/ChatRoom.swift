//
//  ChatRoom.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import Foundation

//트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    let chatroomId: Int //채팅방 고유 ID
    let chatroomImage: [String] //채팅방 이미지
    let chatroomName: String //채팅방 이름
    var chatList: [Chat] = [] //채팅 화면에서 사용할 데이터
}
