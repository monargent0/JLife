//
//  LoadingViewController.swift
//  JLife
//
//  Created by OoO on 5/3/24.
//

import UIKit

final class LoadingViewController: UIViewController {
  
  private let loadingView = LoadingView(frame: .zero)
  
  override func loadView() {
    view = loadingView
  }
  
  override func viewDidLoad() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(popToMainViewController),
                                           name: NSNotification.Name("isGifDone"),
                                           object: nil)
  }
  
  // MARK: - Private Function
  @objc
  private func popToMainViewController() {
    navigationController?.popToRootViewController(animated: true)
  }
}
