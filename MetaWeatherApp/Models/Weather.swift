//
//  Weather.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import Foundation
import ObjectMapper

class transformTemperature: TransformType {
  typealias Object = Int
  typealias JSON = Double
  
  func transformFromJSON(_ value: Any?) -> Object? {
    if let temp = value as? Double {
      return Int(temp * 9 / 5 + 32)
    }
    return nil
  }
  
  func transformToJSON(_ value: Object?) -> JSON? {
    if let temp = value {
      return Double(temp - 32) * 0.5556
    }
    return nil
  }
}

class Weather: Mappable {

  var state: String?
  var abbr: String?
  var temp: Int?
  
  required init?(map: Map) {
    
  }
  
  init(state: String, abbr: String, temp: Int) {
    self.state = state
    self.abbr = abbr
    self.temp = temp
  }
 
  convenience init?(from dict: [String: Any]) {
    guard let state = dict["weather_state_name"] as? String,
      let abbr = dict["weather_state_abbr"] as? String,
      let temp = dict["the_temp"] as? Double
      else {return nil}
    let tempInFarenheit = temp * 9 / 5 + 32
    self.init(state: state, abbr: abbr, temp: Int(tempInFarenheit))
  }
  
  func mapping(map: Map) {
    state <- map["weather_state_name"]
    abbr <- map["weather_state_abbr"]
    temp <- (map["the_temp"], transformTemperature() )
  }
}

//public protocol TransformType {
//  associatedtype Object
//  associatedtype JSON
//
//  func transformFromJSON(_ value: Any?) -> Object?
//  func transformToJSON(_ value: Object?) -> JSON?
//}
