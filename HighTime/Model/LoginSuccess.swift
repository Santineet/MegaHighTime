//
//  LoginSuccess.swift
//  HighTime
//
//  Created by Mairambek on 15/08/2019.
//  Copyright © 2019 Sunrise. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginSuccess: NSObject, Mappable {
   
    var success = LoginToken() 
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
    }
}
