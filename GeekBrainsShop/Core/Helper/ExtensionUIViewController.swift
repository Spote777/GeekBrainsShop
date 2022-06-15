//
//  ExtensionUIViewController.swift
//  GeekBrainsShop
//
//  Created by Павел Заруцков on 29.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String?, message: String?, actionTitles:[String?], actionStyle:[UIAlertAction.Style], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: actionStyle[index], handler: actions[index])
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func changeRootVCWithNavController(identifier: String) {
        guard let window = UIApplication.shared.windows.first else {return}
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        let nav = storyboard.instantiateViewController(withIdentifier: identifier)
        window.rootViewController = nav
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { completed in })
    }
}
