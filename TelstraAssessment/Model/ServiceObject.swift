//
//  ServiceObject.swift
//  TelstraAssessment
//
//  Created by Deepak Pillai on 24/10/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class ServiceObject: Codable {

    var title:String?
    var rows:[ServiceListObject]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case rows
    }
}

class ServiceListObject: NSObject,Codable{
    
    var titleString:String?
    var descriptionString:String?
    var imageLinkStrig:String?
    
    private enum CodingKeys: String, CodingKey {
        
        case titleString = "title"
        case descriptionString = "description"
        case imageLinkStrig = "imageHref"
    }
}
