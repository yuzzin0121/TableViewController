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
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageSendButton: UIButton!
    let messageTextViewPlaceholder = "메시지를 입력하세요"
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
//        setDate()
        configureTableView()
        designTextView(messageTextView)
        scrollToBottom()
        messageSendButton.tintColor = .darkGray
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
    
    func setDate() {
        print("----------")
        for index in 0...chatRoom.chatList.count - 2 {
            let currentDate = String.stringToDate(date: chatRoom.chatList[index].date)
            let nextDate = String.stringToDate(date: chatRoom.chatList[index + 1].date)
            print("current: \(currentDate) , next: \(nextDate)")
            if Date.isSameDate(self: currentDate, as: nextDate) == false {
                let divisionDate = Chat(user: nil, date: Date.dateToString(date: Date.getNextDate(current: currentDate)), message: nil)
                chatRoom.chatList.insert(divisionDate, at: index+1)
                chattingTableView.reloadData()
            }
        }
        print("----------")
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
    
    func designTextView(_ textView: UITextView) {
        textView.delegate = self
        textView.backgroundColor = UIColor(named: "textViewGray")
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 12
        textView.textContainerInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        textView.textColor = .systemGray4
        textView.font = .systemFont(ofSize: 16, weight: .semibold)
        textView.text = messageTextViewPlaceholder
        textView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.separatorStyle = .none
        chattingTableView.estimatedRowHeight = UITableView.automaticDimension
        let FriendChattingNib = UINib(nibName: FriendChattingCell.identifier, bundle: nil)
    
        let MyChattingNib = UINib(nibName: MyChattingCell.identifier, bundle: nil)
        let dateNib = UINib(nibName: DateTableViewCell.identifier, bundle: nil)
        
        chattingTableView.register(FriendChattingNib, forCellReuseIdentifier: FriendChattingCell.identifier)
        chattingTableView.register(MyChattingNib, forCellReuseIdentifier: MyChattingCell.identifier)
        chattingTableView.register(dateNib, forCellReuseIdentifier: DateTableViewCell.identifier)
    }
    
    func changeTextViewHeight(_ height: CGFloat, multi: CGFloat) {
//        messageTextView.heightAnchor.constraint(equalToConstant: CGFloat(height)*multi).isActive = true
//        print("변경")
        DispatchQueue.main.async {
            self.textViewHeightConstraint.constant = (self.messageTextView.font?.lineHeight ?? height) * multi
        }
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
        } else if chatRoom.chatList[indexPath.row].user != nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: FriendChattingCell.identifier, for: indexPath) as! FriendChattingCell
            
            cell.selectionStyle = .none
            cell.configureCell(item: chatRoom.chatList[indexPath.row])
            return cell
        } else if chatRoom.chatList[indexPath.row].user == nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as! DateTableViewCell
            
            cell.selectionStyle = .none
            cell.configureCell(item: chatRoom.chatList[indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    
}


extension ChattingViewController: UITextViewDelegate {
    // textView에 focus를 얻는 경우 발생
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == messageTextViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // textView에 focus를 잃는 경우 발생
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = messageTextViewPlaceholder
            textView.textColor = UIColor(named: "textViewGray")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView.numberOfLine() {
        case 2:
            changeTextViewHeight(32, multi: 2)
        case 3...:
            changeTextViewHeight(32, multi: 3)
        default:
            return
        }
    }
}
