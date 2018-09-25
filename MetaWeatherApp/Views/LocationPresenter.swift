//
//  LocationPresenter.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import Foundation

protocol LocationView: class {
  func setLocations(_ names: [String])
  func displayWeather(_ name: String,_ state: String,_ icon: String,_ temp: Int)
}

struct ListViewData {
  let name: String
  let woeid: String
}

class LocationPresenter {
  
  var currentObjects: [ListViewData]?
  weak var locationView: LocationView?
  
  func fetchData() {
    if let database = NSArray(contentsOf: Bundle.main.url(forResource: "locations", withExtension: "plist")!) as? [[String: Any]] {
      parseData(database)
    }
  }
  
  private func parseData(_ data: [[String: Any]]) {
    currentObjects = data.compactMap {
      guard let name = $0["title"] as? String,
        let woeid = $0["id"] as? String
        else {return nil}
      return ListViewData(name: name, woeid: woeid)
    }
  }
  
  func getLocations() {
    self.fetchData()
    if let locations = currentObjects {
      self.locationView?.setLocations(locations.map{$0.name})
    }
  }
  
  func getWeather(for index: Int) {
    if let locationItem = currentObjects?[index] {
      MetaWeatherAPI.fetchWeather(for: locationItem.woeid) { (location, error) in
        if let loc = location {
          guard let weather = loc.tomorrowWeather() else {return}
          self.locationView?.displayWeather(loc.name!, weather.state!, weather.abbr!, weather.temp!)
        }
      }
    }
  }
}
