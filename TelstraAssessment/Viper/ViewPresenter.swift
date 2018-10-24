//
//  ViewPresenter.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

protocol ViewPresenterProtocol {
    
    func prepareDataToDisplay(_data:ServiceObject?, and error:ErrorInfo?)
}

class ViewPresenter: ViewPresenterProtocol {
    
    var viewController:ViewControllerProtocol?
    
    func prepareDataToDisplay(_data:ServiceObject?, and error:ErrorInfo?) {
        
        //Removing empty array from list
        if let listValues = _data{
         
            var looper = 0
            for dataObject:ServiceListObject in listValues.rows!{
                
                if dataObject.titleString == nil && dataObject.descriptionString == nil && dataObject.imageLinkStrig == nil{
                    
                    listValues.rows?.remove(at: looper)
                }
                looper+=1
            }
            
            self.viewController?.showList(title: listValues.title!, rows: listValues.rows!)
        }
        else{
            
            //Error case
            guard let errorTitle = error?.title else{
                
                return
            }
            self.viewController?.showError(message: errorTitle)
        }
    }
}
