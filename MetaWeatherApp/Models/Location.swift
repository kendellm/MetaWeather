//
//  Location.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import Foundation
import ObjectMapper

class Location: Mappable {
  var name: String?
  var woeid: Int?
  var weather: [Weather]?
  
 required init?(map: Map) {
    
  }

  init(name: String, woeid: Int, weather: [Weather]?) {
    self.name = name
    self.woeid = woeid
    self.weather = weather
  }
  
  convenience init?(from dict: [String: Any]) {
    guard let name = dict["title"] as? String,
    let woeid = dict["woeid"] as? Int,
    let forecast = dict["consolidated_weather"] as? [[String: Any]]
      else {return nil}
    let weather:[Weather] = forecast.compactMap {
      let w = Weather(from: $0)
      return w
    }
    self.init(name: name, woeid: woeid, weather: weather)
  }
  
  func tomorrowWeather() -> Weather? {
    guard let forecast = weather else {return nil}
    if forecast.count > 2 {
      return forecast[1]
    }
    return nil
  }
  
  func mapping(map: Map) {
    name <- map["title"]
    woeid <- map["woeid"]
    weather <- map["consolidated_weather"]
  }
  
}
