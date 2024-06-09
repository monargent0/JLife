//
//  TodoDetailView.swift
//  JLife
//
//  Created by OoO on 5/23/24.
//

import UIKit

final class TodoDetailView: UIView {
  
  // MARK: - Components
  private let timeLabel: UILabel = BodyLabel(for: NameSpace.Notice.notTimeSelected, alignment: .left)
  
  private let todoTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textColor = UIColor(resource: .reversedSystem)
    textView.layer.borderColor = UIColor(named: AppColor.shared.theme?.border ?? CalendarColorPalette.basic.theme.border)?.cgColor
    textView.layer.borderWidth = 0.7
    textView.layer.masksToBounds = true
    textView.layer.cornerRadius = 5
    let customFont = UIFontMetrics.customFont(with: AppFont.shared.style,
                                              of: FontSize.label.size,
                                              for: .body)
    
    return textView
  }()
  
  private let textCountLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.adjustsFontForContentSizeCategory = true
    label.textColor = UIColor(resource: .reversedSystem)
    label.font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                          of: FontSize.label.size,
                                          for: .caption1)
    
    return label
  }()
  
  private let timeSetLabel: UILabel = TitleLabel(for: "시간")
  
  private let timeSetSwitch: UISwitch = {
    let setSwitch = UISwitch()
    setSwitch.translatesAutoresizingMaskIntoConstraints = false
    setSwitch.onTintColor = UIColor(named: AppColor.shared.theme?.mainColor ?? CalendarColorPalette.basic.theme.mainColor)
    
    return setSwitch
  }()
  
  private let timeSetStackView: UIStackView = HorizontalStackView()
  
  private let timeSetDatePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.translatesAutoresizingMaskIntoConstraints = false
    datePicker.backgroundColor = .clear
    datePicker.datePickerMode = .time
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.minuteInterval = 5
    datePicker.locale = Locale(identifier: "ko-KR")
    
    return datePicker
  }()
  
  private let cancelButton: UIButton = TintedButton(title: "취소", color: UIColor.gray)
  
  private let saveButton: UIButton = TintedButton(title: "저장", color: UIColor(resource: .accent))
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private var halfStackView: UIStackView = VerticalFillStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpPreference()
    configureUI()
    configureBackgroundColor()
    setUpAllConstraints()
    setUpTextViewMethod()
    pickerAndSwitchAddTarget()
    tappedBottomButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Function
  private func setUpTextViewMethod() {
    todoTextView.delegate = self
  }
  
  private func setUpPreference() {
    timeSetSwitch.isOn = false
    textCountLabel.text = String(todoTextView.text.count)
    timeSetDatePicker.isHidden = timeSetSwitch.isOn ? false : true
    todoTextView.becomeFirstResponder()
  }
  
  private func pickerAndSwitchAddTarget() {
    timeSetDatePicker.addTarget(self,
                                action: #selector(pickTime),
                                for: .valueChanged)
    timeSetSwitch.addTarget(self,
                            action: #selector(changeSwitch),
                            for: .valueChanged)
  }
  
  @objc
  private func pickTime(_ sender: UIDatePicker) {
    timeLabel.text = dateFormat(sender.date)
  }
  
  private func dateFormat(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.dateFormat = "a h시 mm분"
    
    return formatter.string(from: date)
  }
  
  @objc
  private func changeSwitch(_ sender: UISwitch) {
    if sender.isOn {
      timeSetDatePicker.isHidden = false
      timeLabel.text = dateFormat(timeSetDatePicker.date)
    } else {
      timeSetDatePicker.isHidden = true
      timeLabel.text = NameSpace.Notice.notTimeSelected
    }
  }
  
  private func tappedBottomButton() {
    cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
  }
  
  @objc
  private func tappedCancelButton() {
    NotificationCenter.default.post(name: NSNotification.Name("tappedCancelButton"), object: nil)
  }
  
  // MARK: - Configure UI
  private func configureBackgroundColor() {
    backgroundColor = UIColor(resource: .background)
  }
  
  private func configureUI() {
    [halfStackView, timeSetDatePicker, buttonStackView]
      .forEach { addSubview($0) }
    [timeLabel, todoTextView, textCountLabel, timeSetStackView]
      .forEach {halfStackView.addArrangedSubview($0)}
    [timeSetLabel, timeSetSwitch]
      .forEach {timeSetStackView.addArrangedSubview($0)}
    [cancelButton, saveButton]
      .forEach {buttonStackView.addArrangedSubview($0)}
  }
  
  // MARK: - Constraints
  private func setUpAllConstraints() {
    setUpTextViewConstraints()
    setUpDatePickerConstraints()
    setUpHalfStackViewConstraints()
    setUpButtonStackViewConstraints()
  }
  
  private func setUpTextViewConstraints() {
    todoTextView.heightAnchor.constraint(equalTo: todoTextView.widthAnchor, multiplier: 0.3).isActive = true
  }
  
  private func setUpDatePickerConstraints() {
    NSLayoutConstraint.activate([
      timeSetDatePicker.topAnchor.constraint(equalTo: halfStackView.bottomAnchor, constant: 10),
      timeSetDatePicker.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      timeSetDatePicker.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
      timeSetDatePicker.heightAnchor.constraint(equalTo: timeSetDatePicker.widthAnchor, multiplier: 0.5)
    ])
  }
  
  private func setUpButtonStackViewConstraints() {
    NSLayoutConstraint.activate([
      buttonStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
      buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      buttonStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
    ])
    
    let safeAreaBottom = buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    safeAreaBottom.isActive = true
    safeAreaBottom.priority = .defaultHigh
  }
  
  private func setUpHalfStackViewConstraints() {
    NSLayoutConstraint.activate([
      halfStackView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 5),
      halfStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      halfStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
    ])
  }
}
// MARK: - Extension TodoDetailView
extension TodoDetailView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if todoTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
      saveButton.isEnabled = false
    } else {
      saveButton.isEnabled = true
    }
    let txtCount = String(todoTextView.text.count)
    textCountLabel.text = txtCount
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      todoTextView.resignFirstResponder()
    }
    return true
  }
}
