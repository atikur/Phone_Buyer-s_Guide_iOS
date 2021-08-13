//
//  UIViewController+Extension.swift
//  MobileBuyersGuide
//
//  Created by Atikur Rahman on 13/8/21.
//

import UIKit

extension UIViewController {
    
    public func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
}
