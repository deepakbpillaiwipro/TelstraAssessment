//
//  CoreNetwork.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Alamofire

protocol NetworkLayerProtocol {
    
    func execNetworkRequest(urlPath:String, method: HTTPMethod, encoding: ParameterEncoding, param: Dictionary<String, Any>, shouldCallNetworkRequestInBackground:Bool, completion: @escaping (Data) -> Void, error:@escaping (Error)->Void)
}

class NetworkLayerHelper: NSObject {
    
    @available(*, unavailable, message: "lol.. I wont let you hack my code 😝")
    override init() {
        //do nothing
    }
    
    class fileprivate func getCompleteUrlFrom(baseUrl:String)->String{
        
        //https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
        return "\(Constants.NetworkConstants.kServiceBaseURL)/\(baseUrl)"
    }
    
    class fileprivate func getRequestHeader()-> Dictionary<String, String>{
        
        let dict:[String:String] = ["Content-Type":"application/json"]
        return dict
    }
    
    class fileprivate func createRequest(baseUrl: String, httpMethod: HTTPMethod, headers: Dictionary<String, String>, body: Data?) -> URLRequest? {
        
        guard let url = URL(string: NetworkLayerHelper.getCompleteUrlFrom(baseUrl: baseUrl)) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}

class NetworkLayer: NetworkLayerProtocol {
    
    internal func execNetworkRequest(urlPath:String, method: HTTPMethod, encoding: ParameterEncoding, param: Dictionary<String, Any>, shouldCallNetworkRequestInBackground:Bool, completion: @escaping (Data) -> Void, error:@escaping (Error)->Void) {
        
        CoreNetwork.sharedInstance().performNetworkRequest(url: NetworkLayerHelper.getCompleteUrlFrom(baseUrl: urlPath), method: method, encoding: encoding, param: param, headers: NetworkLayerHelper.getRequestHeader(), shouldCallNetworkRequestInBackground:shouldCallNetworkRequestInBackground, completion: { (dataObj) in
            
            completion(dataObj)
        }) { (errorObj) in
            
            error(errorObj)
        }
    }
}


class CoreNetwork: NSObject {

    static private var alamoFireManager : Alamofire.SessionManager?
    static private var sharedInstanceObj = CoreNetwork()
    
    class func sharedInstance()->CoreNetwork{
        
        return sharedInstanceObj
    }
    
    private override init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        CoreNetwork.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    fileprivate func performNetworkRequest(url: URLConvertible, method:HTTPMethod, encoding:ParameterEncoding, param:Dictionary<String, Any>, headers:HTTPHeaders, shouldCallNetworkRequestInBackground:Bool, completion: @escaping (_ result: Data) -> Void, error:@escaping (_ error:Error)->Void) {
        
        if shouldCallNetworkRequestInBackground == false{
            
            UIUtilities.showGlobalProgressHUD(withTitle: Constants.ApplicationConstants.loadingString)
        }
        CoreNetwork.alamoFireManager?.request(url, method: method, parameters: param, encoding: encoding, headers: headers).responseData { (dataResponse) in
            
            if shouldCallNetworkRequestInBackground == false{
                
                UIUtilities.dismissGlobalHUD()
            }
            
            //For testing purpose only
            do {
                print("\n\n\(dataResponse.request?.url?.absoluteString ?? "")")
                let stringValue = String(data: dataResponse.data!, encoding: .ascii) ?? ""
                let backToData = stringValue.data(using: .utf8)! as Data
                let jsonDataOld = try JSONSerialization.jsonObject(with: backToData) as! [String:Any]
                let jsonData: Data = try JSONSerialization.data(withJSONObject: jsonDataOld, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
                let backToString = String(data: jsonData, encoding: String.Encoding.utf8)
                print(backToString as Any)
            }
                
            catch let errorObj {
                
                print(errorObj)
            }
            
            if dataResponse.error == nil{
                
                let stringValue = String(data: dataResponse.data!, encoding: .ascii) ?? ""
                let backToData = stringValue.data(using: .utf8)! as Data
                completion(backToData)
            }
            else{
                
                error(dataResponse.error!)
            }
        }
    }
}
