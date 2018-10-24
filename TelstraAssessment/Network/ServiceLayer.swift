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
    func getListData(completion:@escaping(_ dataObj:ServiceObject)->Void, error:@escaping (_ errorObj:POSError)->Void){
        
        if CommonUtilities.isConnectedToInternet(){
            
            let serviceUrl = "s/2iodh4vg0eortkl/facts.json"
            ServiceLayer.sharedInstance().networkLayerProtocol?.execNetworkRequest(urlPath: serviceUrl, method: .get, encoding: URLEncoding.default, param: [:], shouldCallNetworkRequestInBackground: false, completion: { (dataObj) in
                
                do{
                    
                    let decodedListResponseData:ServiceObject = try JSONDecoder().decode(ServiceObject.self, from: dataObj)
                    
                    //Removing empty array from list
                    var looper = 0
                    for dataObject:ServiceListObject in decodedListResponseData.rows!{
                        
                        if dataObject.titleString == nil && dataObject.descriptionString == nil && dataObject.imageLinkStrig == nil{
                            
                            decodedListResponseData.rows?.remove(at: looper)
                        }
                        looper+=1
                    }
                    completion(decodedListResponseData)
                }
                catch let errorObj {
                    
                    //Try catch error block
                    error(ErrorHandler.handleError(errorObj: errorObj, errorType: .jsonParserError, file: #file, function: #function))
                }
            }, error: { (errorObj) in
                
                //Network error block
                error(ErrorHandler.handleError(errorObj: errorObj, errorType: .networkError, file: #file, function: #function))
            })
        }
        else{
            
            //Show error
        }
    }
}
