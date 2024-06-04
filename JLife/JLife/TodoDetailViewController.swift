//
//  TodoDetailViewController.swift
//  JLife
//
//  Created by OoO on 5/23/24.
//

import UIKit

final class TodoDetailViewController: UIViewController {
  
  private let todoDetailView = TodoDetailView(frame: .zero)
  
  override func loadView() {
    view = todoDetailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tappedBottomButton()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  private func tappedBottomButton() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(popTodoDetailViewController),
                                           name: NSNotification.Name("tappedCancelButton"),
                                           object: nil)
  }
  
  @objc
  private func popTodoDetailViewController() {
    navigationController?.popViewController(animated: true)
  }
}
