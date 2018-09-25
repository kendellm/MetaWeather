//
//  WeatherView.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

class WeatherView: UIView {
  
  lazy var locationLabel: UILabel = {
    let lbl = UILabel(frame: CGRect(x: 30,
                                    y: 30,
                                    width: self.frame.width/2,
                                    height: 25))
    lbl.text = "Location"
    lbl.textColor = .white
    lbl.font = UIFont(name: lbl.font.fontName, size: 25)
    return lbl
  }()
  
  lazy var tempLabel: UILabel = {
    let lbl = UILabel(frame: CGRect(x: 0,
                                    y: 50,
                                    width: self.frame.width,
                                    height: 100))
    lbl.text = "00"
    lbl.textColor = .white
    lbl.font = UIFont(name: lbl.font.fontName, size: 105)
    lbl.textAlignment = .center
    return lbl
  }()
  
  lazy var tempIcon: UIImageView = {
    let img = UIImageView(frame: CGRect(x: 75,
                                        y: 75,
                                        width: 50,
                                        height: 50))
    img.image = UIImage(named: "sun_placeholder")
    return img
  }()
  
  lazy var weatherLabel: UILabel = {
    let lbl = UILabel(frame: CGRect(x: 0,
                                    y: 150,
                                    width: self.frame.width,
                                    height: 25))
    lbl.text = "weather"
    lbl.textColor = .white
    lbl.font = UIFont(name: lbl.font.fontName, size: 20)
    lbl.textAlignment = .center
    return lbl
  }()
  
  lazy var farenheitLabel: UILabel = {
    let lbl = UILabel(frame: CGRect(x: tempIcon.frame.maxX + 150,
                                    y: tempIcon.frame.minY - 20,
                                    width: 30,
                                    height: 25))
    lbl.text = "o"
    lbl.textColor = .white
    lbl.font = UIFont(name: lbl.font.fontName, size: 25)
    return lbl
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(locationLabel)
    self.addSubview(weatherLabel)
    self.addSubview(farenheitLabel)
    self.addSubview(tempLabel)
    self.addSubview(tempIcon)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
}
