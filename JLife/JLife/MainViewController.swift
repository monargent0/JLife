//
//  MainViewController.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import UIKit

final class MainViewController: UIViewController {
  
  private let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
  private let launchedVersion = UserDefaults.standard.string(forKey: "launchedVersion")
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
    if launchedVersion == nil || launchedVersion != currentVersion {
      let loadingViewController = LoadingViewController()
      
      navigationController?.pushViewController(loadingViewController,
                                               animated: true)
    
      UserDefaults.standard.set(currentVersion, forKey: "launchedVersion")
      UserDefaults.standard.synchronize()
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
