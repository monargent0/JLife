//
//  SettingViewController.swift
//  JLife
//
//  Created by OoO on 2024/02/16.
//

import UIKit

final class SettingViewController: UIViewController {
  
  private let fontManager: UserDefaultsManager<String>
  private let colorManager: UserDefaultsManager<Theme>
  private let settingView = SettingView(frame: .zero)
  
  init(fontManager: UserDefaultsManager<String>, colorManager: UserDefaultsManager<Theme>) {
    self.fontManager = fontManager
    self.colorManager = colorManager
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = settingView
  }
  
  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tappedApplyButton()
  }
  
  // MARK: - Private Function
  private func tappedApplyButton() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(popToMainViewControllerWithApplyTheme),
                                           name: NSNotification.Name("tapApplyButton"),
                                           object: nil)
  }
  
  // TODO: - 색상 테마 적용
  @objc
  private func popToMainViewControllerWithApplyTheme() {
    self.dismiss(animated: true)
  }
}
