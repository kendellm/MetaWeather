//
//  NetworkService.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

enum NetworkError:Error{
  case BadURL
  case NoDataOnServer
  case DataContainedNoObject
}

class NetworkService {
  
  private init() {}
  
  static func startRequest(request: URLRequest,
                           success: @escaping (_ response: URLResponse?, _ data: Data) -> Void,
                           failure: @escaping (_ error: Error?) -> Void) {
    
    NetworkService.startRequest(request: request,
                                session: URLSession.shared,
                                success: success,
                                failure: failure)
  }
  
  static func startRequest(request: URLRequest,
                           session: URLSession,
                           success: @escaping (_ response: URLResponse?, _ data: Data) -> Void,
                           failure: @escaping (_ error: Error?) -> Void) {
    
    session.dataTask(with: request) { (data, response, error) in
      guard error == nil else {
        failure(error)
        return
      }
      guard let data = data else {
        failure(nil)
        return
      }
      success(response, data)
      }.resume()
  }
}
