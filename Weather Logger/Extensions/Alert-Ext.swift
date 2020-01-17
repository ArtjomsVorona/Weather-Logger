//
//  Alert-Ext.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 15/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

extension UIViewController {
    func basicAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func goToSettingsAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func autoDismissAlert(title: String) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let dismissTime = DispatchTime.now() + 0.7
        DispatchQueue.main.asyncAfter(deadline: dismissTime) {
            alert.dismiss(animated: true, completion: nil)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
