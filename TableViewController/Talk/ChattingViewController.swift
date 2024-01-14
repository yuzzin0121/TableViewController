//
//  ChattingViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class ChattingViewController: UIViewController {
    var chatRoom: ChatRoom = ChatRoom(chatroomId: 0, chatroomImage: [""], chatroomName: "채팅방")
    @IBOutlet weak var chattingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        scrollToBottom()
    }

    private func scrollToBottom() {
//        chattingTableView.setContentOffset(.init(x: 0, y: getTableViewBottomYOffset()), animated: true)
        DispatchQueue.main.async {
            let index = IndexPath(row: self.chatRoom.chatList.count - 1, section: 0)
            self.chattingTableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
    }
    
    // 테이블뷰의 맨 밑 Y좌표
//    private func getTableViewBottomYOffset() -> CGFloat {
//        let contentSize = chattingTableView.contentSize.height
//        let frameSize = chattingTableView.frame.size.height
//        return contentSize - frameSize
//    }
}

extension ChattingViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = chatRoom.chatroomName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(pop))
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.separatorStyle = .none
        chattingTableView.estimatedRowHeight = UITableView.automaticDimension
        let FriendChattingNib = UINib(nibName: FriendChattingCell.identifier, bundle: nil)
    
        let MyChattingNib = UINib(nibName: MyChattingCell.identifier, bundle: nil)
        
        chattingTableView.register(FriendChattingNib, forCellReuseIdentifier: FriendChattingCell.identifier)
        chattingTableView.register(MyChattingNib, forCellReuseIdentifier: MyChattingCell.identifier)
    }
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatRoom.chatList[indexPath.row].user == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyChattingCell.identifier, for: indexPath) as! MyChattingCell
            
            cell.selectionStyle = .none
            cell.configureCell(item: chatRoom.chatList[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendChattingCell.identifier, for: indexPath) as! FriendChattingCell
            
            cell.selectionStyle = .none
            cell.configureCell(item: chatRoom.chatList[indexPath.row])
            return cell
        }
    }
    
    
}

