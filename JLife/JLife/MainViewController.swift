//
//  MainViewController.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import UIKit

final class MainViewController: UIViewController {
  
  private let isLaunchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
  private let mainCalendarView = MainCalendarView(frame: .zero)
  
  // MARK: - View LifeCycle
  override func loadView() {
    view = mainCalendarView
  }
  
  override func viewDidLoad() {
    startLoadingViewController()
    tappedSettingButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavBarHidden()
  }
  
  // MARK: - Private Function
  private func setNavBarHidden() {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  private func startLoadingViewController() {
    if !isLaunchedBefore {
      let loadingViewController = LoadingViewController()
      
      navigationController?.pushViewController(loadingViewController,
                                               animated: true)
      
      UserDefaults.standard.setValue(true, forKey: "launchedBefore")
    }
  }
  
  private func tappedSettingButton() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(presentModalSettingViewController),
                                           name: NSNotification.Name("tapSettingButton"),
                                           object: nil)
  }
  
  @objc
  private func presentModalSettingViewController() {
    let settingVC = SettingViewController()
    self.present(settingVC, animated: true)
  }
}
