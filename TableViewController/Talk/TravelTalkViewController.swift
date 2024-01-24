//
//  TravelTalkViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class TravelTalkViewController: UIViewController {
    @IBOutlet weak var travelTalkTableView: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredChatList: [ChatRoom] = []
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    var mockChatList = ChatInfo.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        designSearchBar()
        configureTableView()
    }
    

}

extension TravelTalkViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = "TRAVEL TALK"
    }
    
    func configureTableView() {
        travelTalkTableView.delegate = self
        travelTalkTableView.dataSource = self
        travelTalkTableView.estimatedRowHeight = 75
        travelTalkTableView.separatorStyle = .none
        let chatRoomNib = UINib(nibName: UserTableViewCell.identifier, bundle: nil)
        let fourUserChatRoomNib = UINib(nibName: FourUserTableViewCell.identifier, bundle: nil)
        
        travelTalkTableView.register(chatRoomNib, forCellReuseIdentifier: UserTableViewCell.identifier)
        travelTalkTableView.register(fourUserChatRoomNib, forCellReuseIdentifier: FourUserTableViewCell.identifier)
    }
    
    func designSearchBar() {
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요"
        self.navigationItem.hidesSearchBarWhenScrolling = false // 스크롤할 때도 서치바 보이기
        // 서치바에 text가 업데이트 될 때마다 불리는 메소드
        searchController.searchResultsUpdater = self
    }
    
    
}

extension TravelTalkViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        for chat in mockChatList {
            if chat.chatroomName.contains(text) {
                filteredChatList.append(chat)
            }
        }
        
        self.travelTalkTableView.reloadData()
    }
}

extension TravelTalkViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredChatList.count : self.mockChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 검색 중일 경우
        if self.isFiltering {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
            cell.selectionStyle = .none
            
            // filtering된 리스트를 보여줌
            cell.configureCell(item: filteredChatList[indexPath.row])
            
            return cell
        } else {
            switch mockChatList[indexPath.row].chatroomImage.count {
            case 4...:  // 4명 이상일 경우
                let cell = tableView.dequeueReusableCell(withIdentifier: FourUserTableViewCell.identifier, for: indexPath) as! FourUserTableViewCell
                cell.selectionStyle = .none
                cell.configureCell(item: mockChatList[indexPath.row])
                return cell
            default:    // 4명 미만일 경우
                let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
                cell.selectionStyle = .none
                cell.configureCell(item: mockChatList[indexPath.row])
                return cell
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chattingVC = storyboard?.instantiateViewController(identifier: ChattingViewController.identifier) as! ChattingViewController
        
        chattingVC.chatRoom = mockChatList[indexPath.row]
        
        navigationItem.searchController?.searchBar.text = ""
        navigationController?.pushViewController(chattingVC, animated: true)
    }
}
