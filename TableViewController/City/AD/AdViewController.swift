//
//  AdViewController.swift
//  TableViewController
//
//  Created by 조유진 on 1/12/24.
//

import UIKit

class AdViewController: UIViewController, ViewProtocol {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var adLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        designButton(closeButton)
    }
    
    func configureView() {
        navigationItem.title = "광고 화면"
        adLabel.text = "광고 화면"
    }
    
    func designButton(_ button: UIButton) {
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}
