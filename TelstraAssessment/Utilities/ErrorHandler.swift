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

struct POSError: Error {
    
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
    class func handleError(errorObj:Error, errorType:ErrorConstants, file:String, function:String)->POSError{
        
        //This code is for temp puropse.
        print("Error in \(function):: \(errorObj.localizedDescription)")
        return POSError.init(title: "error string", code: 12)
    }
}
