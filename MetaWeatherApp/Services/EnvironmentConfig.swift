//
//  EnvironmentConfig.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/27/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import Foundation

private let DEFAULT_ENV = EnvironmentType.PRODUCTION

//Enum for possible values for Different Environments
enum EnvironmentType :String {
  
  case PRODUCTION
  case PREVIEW
  case QA

  //QA4 is created for testing the okta by connecting to Datapower > David's VM
  case QA5
  var configuration: EnvironmentConfig {
    
    switch self {
    case .PRODUCTION:
      return BUILD_RELEASE_CONFIG
    case .PREVIEW:
      return BUILD_PREVIEW_CONFIG
    case .QA:
      return BUILD_QA_CONFIG
    default:
      return BUILD_QA_CONFIG
    }
  }
}

struct EnvironmentConfig {
  
  let environment:EnvironmentType
  let name:String
  let isDeveloperSettingsOn:Bool

  static func getCurrentEnvironment () -> EnvironmentType {
    return CURRENT_ENV
  }
  
  static func switchEnvironment (_ environment:EnvironmentType) {
    CURRENT_ENV = environment
  }
}

//Current Build Environment
private var CURRENT_ENV:EnvironmentType {
  get {
    if let preferenceValue = UserPreference.readString("Environment"), let env =  EnvironmentType(rawValue: preferenceValue){
      return env
    }
    return DEFAULT_ENV
    
    
  }
  set (newVal) {
    if (newVal.configuration.isDeveloperSettingsOn) {
      UserPreference.saveString("Environment", value: newVal.rawValue)
    }
  }
}


private let BUILD_RELEASE_CONFIG = EnvironmentConfig (
  environment : .PRODUCTION,
  name: "Production",
  isDeveloperSettingsOn : false

)

private let BUILD_PREVIEW_CONFIG = EnvironmentConfig (
  
  environment : .PREVIEW,
  name: "Preview",
  isDeveloperSettingsOn : false
  
)

private let BUILD_QA_CONFIG = EnvironmentConfig (
  environment : .QA,
  name : "QA",
  isDeveloperSettingsOn : true
)




class UserPreference {
  
  class func saveString(_ key:String, value:String?) {
    if let saveValue = value {
      UserDefaults.standard.setValue(saveValue, forKey: key)
    }
  }
  
  class func readString(_ key:String) -> String? {
    
    if let storedValue =  UserDefaults.standard.value(forKey: key) as? String {
      return storedValue
    }
    return nil
  }
}
