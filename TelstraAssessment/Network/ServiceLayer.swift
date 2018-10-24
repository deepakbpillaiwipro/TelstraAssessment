//
//  ServiceLayer.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Alamofire

class ServiceLayer: NSObject {

    
    static private let servicesSharedInstanceObj = ServiceLayer()
    private var networkLayerProtocol:NetworkLayerProtocol?
    
    class func sharedInstance()->ServiceLayer{
        
        return servicesSharedInstanceObj
    }
    
    private func setup(){
        
        let networkLayer = NetworkLayer()
        self.networkLayerProtocol = networkLayer
    }
    
    private override init() {
        
        super.init()
        setup()
    }
    
    //MARK:- INTERNAL METHODS
    func getListData(completion:@escaping(_ dataObj:ServiceObject)->Void, error:@escaping (_ errorObj:ErrorInfo)->Void){
        
        if CommonUtilities.isConnectedToInternet(){
            
            let serviceUrl = "s/2iodh4vg0eortkl/facts.json"
            ServiceLayer.sharedInstance().networkLayerProtocol?.execNetworkRequest(urlPath: serviceUrl, method: .get, encoding: URLEncoding.default, param: [:], shouldCallNetworkRequestInBackground: false, completion: { (dataObj) in
                
                do{
                    
                    let decodedListResponseData:ServiceObject = try JSONDecoder().decode(ServiceObject.self, from: dataObj)
                    completion(decodedListResponseData)
                }
                catch let errorObj {
                    
                    //Try catch error block
                    error(ErrorHandler.handleError(errorObj: errorObj as NSError, errorType: .jsonParserError, file: #file, function: #function))
                }
            }, error: { (errorObj) in
                
                //Network error block
                error(ErrorHandler.handleError(errorObj: errorObj as NSError, errorType: .networkError, file: #file, function: #function))
            })
        }
        else{
            
            //Show error
            let errorObject = NSError(domain:Constants.NetworkConstants.kServiceError, code:401, userInfo:[Constants.NetworkConstants.kErrorUserInfo:Constants.ApplicationConstants.networkConnectivityIssueString])
            error(ErrorHandler.handleError(errorObj: errorObject, errorType: .apiServiceError, file: #file, function: #function))
        }
    }
}
