//
//  Constants.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

struct Constants {
    
    struct NetworkConstants {
        
        static let kServiceBaseURL = "https://dl.dropboxusercontent.com"
        static let kSuccessString = "SUCCESS"
        static let kServiceError = "Service Error"
        static let kErrorUserInfo = "UserInfo"
    }
    
    struct ApplicationConstants {
        
        static let loadingString = "Loading.."
        static let okeyString = "OK"
        static let placeholderImage = "placeholder"
        static let networkConnectivityIssueString = "Unable to connect to network. Please check your internet connection"
        static let unknownErrorString = "Unknown Error"
        static let noRecordErrorString = "No records to display"
    }
}
