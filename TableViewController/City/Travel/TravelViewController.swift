//
//  TravelViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class TravelViewController: UIViewController {
    @IBOutlet weak var travelTableView: UITableView!
    
    let travelList = TravelInfo.travelList
    
    let backgroundColors: [UIColor] = [
        .red, .green, .yellow, .orange, .blue, .purple, .brown, .gray, .lightGray, .cyan, .systemMint, .systemTeal
    ]
    
    
    var adList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        adList = getAdList()
    }

    func getAdList() -> [String] {
        var list: [String] = []
        
        for travel in travelList {
            if travel.ad {
                list.append(travel.title)
            }
        }
        return list
    }
}

extension TravelViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = "도시 상세 정보"
    }
}

extension TravelViewController {
    func configureTableView() {
        travelTableView.delegate = self
        travelTableView.dataSource = self
        
        travelTableView.rowHeight = 160
        
        let xib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
        travelTableView.register(xib, forCellReuseIdentifier: TravelTableViewCell.identifier)
        
        let xib2 = UINib(nibName: "AdTableViewCell", bundle: nil)
        travelTableView.register(xib2, forCellReuseIdentifier: "AdTableViewCell")
    }
    
    func getRandomColor() -> UIColor {
        return backgroundColors.randomElement()!
    }
}

extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if travelList[indexPath.row].ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier, for: indexPath) as! AdTableViewCell
            
            cell.configureCell(item: travelList[indexPath.row].title, backgroundColor: getRandomColor())
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
            
            cell.configureCell(item: travelList[indexPath.row])
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelList[indexPath.row].ad {
            return 74
        } else {
            return 162
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MainSB = UIStoryboard(name: "Main", bundle: nil)
        
        if travelList[indexPath.row].ad {
            let AdVC = MainSB.instantiateViewController(withIdentifier: AdViewController.identifier)
            let nav = UINavigationController(rootViewController: AdVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        } else {
            let TravelDetailVC = MainSB.instantiateViewController(withIdentifier: TravelDetailViewController.identifier)
            self.navigationController?.pushViewController(TravelDetailVC, animated: true)
        }
    
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
