//
//  GlobalCache.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

class GlobalCache {
  private init() {}
  static let shared = GlobalCache()
  let imageCache = NSCache<NSString,UIImage>()
}
