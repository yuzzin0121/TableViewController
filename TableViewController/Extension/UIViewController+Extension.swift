//
//  UIViewController+Extension.swift
//  TableViewController
//
//  Created by 조유진 on 1/24/24.
//


import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping () -> Void, cancelHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            actionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            cancelHandler()
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func showTheaterActionSheet(completionHandler: @escaping (TheaterName) -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         
         for item in TheaterName.allCases {
             let action = UIAlertAction(title: item.rawValue, style: .default) { _ in
                 completionHandler(item)
             }
             alert.addAction(action)
         }
         
         present(alert, animated: true)
    }
  
}
