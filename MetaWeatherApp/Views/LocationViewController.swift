//
//  LocationViewController.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
  
  private let reuseIdentifier = "myCell"
  var presenter: LocationPresenter?
  var tableHeightConstraint: NSLayoutConstraint?
  var tableData = [String]()
  
  lazy var tableView: UITableView = {
    let t = UITableView()
    t.delegate = self
    t.dataSource = self
    t.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    t.layer.cornerRadius = 10
    return t
  }()
  
  lazy var weatherView: WeatherView = {
    let wv = WeatherView(frame: CGRect(x: 0,
                                       y: 0,
                                   width: self.view.frame.width,
                                  height: self.view.frame.height/2))
    return wv
  }()
  
  lazy var backgroundImage: UIImageView = {
    let img = UIImageView(frame: view.frame)
    img.image = UIImage(named: "blue_bg")
    return img
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter = LocationPresenter()
    presenter?.locationView = self
    presenter?.getLocations()
    view.addSubview(backgroundImage)
    view.addSubview(weatherView)
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableHeightConstraint = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10)
    tableHeightConstraint?.isActive = true
    NSLayoutConstraint.activate([
      tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
      ])
  }
}

// MARK: Table View Delegate
extension LocationViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.getWeather(for: indexPath.row)
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.tableHeightConstraint?.constant = 10
    UIView.animate(withDuration: 0.25, animations: {
      self.view.layoutIfNeeded()
    })
  }
}

extension LocationViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
    cell.textLabel?.text = self.tableData[indexPath.row]
    return cell
  }
}

// MARK: Location View
extension LocationViewController: LocationView {
  
  func setLocations(_ names: [String]) {
    self.tableData = names
    tableView.reloadData()
  }
  
  func displayWeather(_ name: String,_ state: String,_ icon: String,_ temp: Int) {
    DispatchQueue.main.sync {
      self.weatherView.locationLabel.text = name
      self.weatherView.tempLabel.text = "\(temp)"
      self.weatherView.weatherLabel.text = state
      if let image = GlobalCache.shared.imageCache.object(forKey: icon as NSString) {
         self.weatherView.tempIcon.image = image
      }
      self.tableHeightConstraint?.constant = 200
        UIView.animate(withDuration: 0.25, animations: {
          self.view.layoutIfNeeded()
        })
      }
    }
}

