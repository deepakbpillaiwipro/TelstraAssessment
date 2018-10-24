//
//  CommonUtilities.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Alamofire

private struct Connectivity {
    
    static let sharedInstance = NetworkReachabilityManager()!
    
    static var isConnectedToInternet:Bool {
        
        return self.sharedInstance.isReachable
    }
}

class CommonUtilities: NSObject {
    
    class func isConnectedToInternet()->Bool{
        
        //return false
        if Connectivity.isConnectedToInternet {
            
            return true
        }
        
        return false
    }
    
    class func showAlert(message:String)->UIAlertController{
        
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        return alert
    }
}
