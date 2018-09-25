//
//  MetaWeatherAPI.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

extension Data {
  var jsonString: String {
    return NSString(data: self, encoding: String.Encoding.utf8.rawValue)! as String
  }
}

class MetaWeatherAPI {
  
  private init() {}
  private static let baseUrl = "https://www.metaweather.com/api/"
  private static let imageUrl = "https://www.metaweather.com/static/img/weather/png/"
  
  static func fetchWeather(for woeid: String, completion: @escaping(_ location: Location?, _ error: Error?)->()){
    guard let url = URL(string: "\(baseUrl)location/\(woeid)/") else {
      completion(nil, nil)
      return
    }
    let fetchRequest = URLRequest(url: url)
    NetworkService.startRequest(request: fetchRequest, success: { (_, data) in
        if let loca = Location(JSONString: data.jsonString) {
          if let weather = loca.tomorrowWeather() {
            addStateToCache(for: weather, completion: {
              completion(loca, nil)
            })
          }
          return
        }
    }) { (_) in
    }
  }
  
  private static func addStateToCache(for weather: Weather, completion: @escaping()->()){
    if let _ = GlobalCache.shared.imageCache.object(forKey: weather.abbr! as NSString) {
      completion()
      return
    }
    guard let url = URL(string: "\(imageUrl)\(weather.abbr!).png") else {
      completion()
      return
    }
    let fetchRequest = URLRequest(url: url)
    NetworkService.startRequest(request: fetchRequest, success: { (_, data) in
      guard let image = UIImage(data: data) else {
        completion()
        return
      }
      GlobalCache.shared.imageCache.setObject(image, forKey: weather.abbr! as NSString)
      completion()
    }) { (_) in
    }
  }
  
}
