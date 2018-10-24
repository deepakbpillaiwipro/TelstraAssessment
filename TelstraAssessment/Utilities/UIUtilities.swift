//
//  UIUtilities.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import MBProgressHUD

class UIUtilities: NSObject {

    
    class func showGlobalProgressHUD(withTitle title: String?) {
        
        DispatchQueue.main.async {
            
            let window: UIWindow? = UIApplication.shared.windows.last
            let hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.isUserInteractionEnabled = false
            hud.label.text = title
        }
    }
    
    class func dismissGlobalHUD() {
        
        DispatchQueue.main.async {
            
            let window: UIWindow? = UIApplication.shared.windows.last
            MBProgressHUD.hide(for: window!, animated: true)
        }
    }
}
