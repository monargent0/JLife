//
//  MainViewController.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import UIKit

final class MainViewController: UIViewController {
  let fontManager: UserDefaultsManager<String>
  let colorManager: UserDefaultsManager<Theme>
  
  private let currentVersion = Bundle.main.object(forInfoDictionaryKey: Preference.Bundle.appVersion.key) as? String ?? ""
  private let launchedVersion = UserDefaults.standard.string(forKey: Preference.UserDefaults.launchedBefore.key)
  private let mainCalendarView = MainCalendarView(frame: .zero)
  
  init(fontManager: UserDefaultsManager<String>, colorManager: UserDefaultsManager<Theme>) {
    self.fontManager = fontManager
    self.colorManager = colorManager
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View LifeCycle
  override func loadView() {
    view = mainCalendarView
  }
  
  override func viewDidLoad() {
    setUpUserDefaults()
    startLoadingViewController()
    tappedNavBarButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUpNavigationBar()
  }
  
  // MARK: - Private Function
  private func setUpNavigationBar() {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  private func setUpUserDefaults() {
    AppFont.shared.style = fontManager.getUserDefaultsValue()
    AppColor.shared.theme = colorManager.getUserDefaultsValue()
  }
  
  private func startLoadingViewController() {
    if launchedVersion == nil || launchedVersion != currentVersion {
      let loadingViewController = LoadingViewController()
      
      navigationController?.pushViewController(loadingViewController,
                                               animated: true)
    
      UserDefaults.standard.set(currentVersion, forKey: "launchedVersion")
    }
  }
  
  private func tappedNavBarButton() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(presentSettingViewController),
                                           name: NSNotification.Name("tappedSettingButton"),
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(presentSearchingViewController),
                                           name: NSNotification.Name("tappedSearchingButton"),
                                           object: nil)
  }
  
  @objc
  private func presentSettingViewController() {
    let settingVC = SettingViewController()
    self.present(settingVC, animated: true)
  }
  // TODO: - 임시로 TodoDerail 뷰 연결 중 Search View 생성 시 변경하기
  @objc
  private func presentSearchingViewController() {
    let searchingVC = TodoDetailViewController()
    navigationController?.pushViewController(searchingVC, animated: true)
  }
}
