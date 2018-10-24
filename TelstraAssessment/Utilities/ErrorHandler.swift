//
//  ErrorHandler.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

public enum ErrorConstants:Int{
    
    case networkError = 1
    case unknownError
    case apiServiceError
    case jsonParserError
}

struct ErrorInfo: Error {
    
    var title:String?
    var code:Int?
    
    init(title: String?, code: Int){
        
        self.title = title
        self.code = code
    }
}

//This class will be responsable for handling error in this application. Based on the error description and the error type, we gonna decide what to do with it. We can alert user based on the error or we can log the error locally or  push to server
class ErrorHandler: NSObject {
    
    //Decide what to do with the error object
    class func handleError(errorObj:NSError, errorType:ErrorConstants, file:String, function:String)->ErrorInfo{
        
        //This code is for temp puropse.
        print("Error in \(function):: \(errorObj.localizedDescription)")
        guard let errorInfo = errorObj.userInfo[Constants.NetworkConstants.kErrorUserInfo] else {
            
            return ErrorInfo.init(title: Constants.ApplicationConstants.unknownErrorString, code: -1)
        }
        return ErrorInfo.init(title: errorInfo as? String, code: errorObj.code)
    }
}
