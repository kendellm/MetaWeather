//
//  RootViewController.swift
//  MetaWeatherApp
//
//  Created by kendell monrose on 9/8/18.
//  Copyright © 2018 kendell monrose. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

  fileprivate var navController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
      let locationVC = LocationViewController()
      locationVC.view.frame = view.bounds
      locationVC.title = EnvironmentConfig.getCurrentEnvironment().configuration.name
      navController = UINavigationController(rootViewController: locationVC)
      navController.navigationBar.isTranslucent = false
      view.addSubview(navController.view)
  }
}
