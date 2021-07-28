//
//  Weather.swift
//  RXSwiftTest
//
//  Created by Pavel Spitcyn on 26.07.2021.
//

import Foundation
import SwiftyJSON

class Weather {
   var name:String?
   var degrees:Double?
 
   init(json: AnyObject) {
    
    let data = JSON(json)
    
    self.name = data["name"].stringValue
    self.degrees = data["main"]["temp"].doubleValue
    
   }
    
}
