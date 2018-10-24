//
//  ViewInteractor.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

protocol ViewInteractorProtocol {
    
    func getListOfData()
}

class ViewInteractor: ViewInteractorProtocol {
    
    var presenter:ViewPresenterProtocol?
    func getListOfData() {
        
        ServiceLayer.sharedInstance().getListData(completion: { (obj) in
            
            
        }) { (errorObj) in
            
            
        }
    }
}
