//
//  SettingViewController.swift
//  JLife
//
//  Created by OoO on 2024/02/16.
//

import UIKit

final class SettingViewController: UIViewController {
      
    // MARK: - 변수 선언
    private let settingView = SettingView(frame: .zero)
    
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
    
    // TODO: 색상 테마 적용
    @objc
    private func popToMainViewControllerWithApplyTheme() {
        self.dismiss(animated: true)
    }
}
