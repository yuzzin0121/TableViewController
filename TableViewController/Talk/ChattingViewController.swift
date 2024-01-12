//
//  ChattingViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class ChattingViewController: UIViewController {
    let chatRoom: ChatRoom = ChatRoom(chatroomId: 0, chatroomImage: [""], chatroomName: "채팅방")

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

}

extension ChattingViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = chatRoom.chatroomName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(pop))
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
}
