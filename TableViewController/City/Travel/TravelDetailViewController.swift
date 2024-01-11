//
//  TravelDetailViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class TravelDetailViewController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
}

extension TravelDetailViewController: ViewProtocol {
    func configureView() {
        navigationItem.title = "관광지 화면"
        detailLabel.design(text: "관광지 화면", font: .boldSystemFont(ofSize: 24))
    }
    
    
}
