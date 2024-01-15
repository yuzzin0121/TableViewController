//
//  MagazineTableViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/8/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    let magazineList = MagazineInfo.magazineList

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 480
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineList.count
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.identifier, for: indexPath) as! MagazineTableViewCell
        
        cell.configureCell(item: magazineList[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let magazineWebVC = storyboard?.instantiateViewController(identifier: MagazineWebViewController.identifier) as! MagazineWebViewController
        
        magazineWebVC.urlString = magazineList[indexPath.row].link
        
        navigationController?.pushViewController(magazineWebVC, animated: true)
    }
}
