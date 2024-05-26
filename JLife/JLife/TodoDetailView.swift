//
//  TodoDetailView.swift
//  JLife
//
//  Created by OoO on 5/23/24.
//

import UIKit

final class TodoDetailView: UIView {
  
  // MARK: - Components
  private let timeLabel: UILabel = {
    let label = UILabel()
    let customFont = UIFont(name: AppFont.cafe24Font,
                            size: UIFont.labelFontSize)
    ?? UIFont.preferredFont(forTextStyle: .headline)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
    label.textColor = UIColor(resource: .reversedSystem)
    
    return label
  }()
  
  // TODO: - border 색상 사용자 테마 색으로 적용
  private let todoTextView: UITextView = {
    let textView = UITextView()
    let customFont = UIFont(name: AppFont.cafe24Font,
                            size: UIFont.labelFontSize)
    ?? UIFont.preferredFont(forTextStyle: .body)
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
    textView.textColor = UIColor(resource: .reversedSystem)
    textView.layer.borderColor = UIColor(resource: .accent).cgColor
    textView.layer.borderWidth = 0.7
    textView.layer.masksToBounds = true
    textView.layer.cornerRadius = 5
    
    return textView
  }()
  
  private let txtCountLabel: UILabel = {
    let label = UILabel()
    let customFont = UIFont(name: AppFont.cafe24Font,
                            size: UIFont.labelFontSize)
    ?? UIFont.preferredFont(forTextStyle: .caption1)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: customFont)
    label.textColor = UIColor(resource: .reversedSystem)
    
    return label
  }()
  
  private let timeSetLabel: UILabel = {
    let label = UILabel()
    let customFont = UIFont(name: AppFont.cafe24Font,
                            size: UIFont.labelFontSize)
    ?? UIFont.preferredFont(forTextStyle: .largeTitle)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "시간"
    label.textAlignment = .center
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: customFont)
    label.textColor = UIColor(resource: .reversedSystem)
    
    return label
  }()
  
  // TODO: - tint 색상 사용자 테마 색으로 적용
  private let timeSetSwitch: UISwitch = {
    let setSwitch = UISwitch()
    setSwitch.translatesAutoresizingMaskIntoConstraints = false
    setSwitch.onTintColor = UIColor(resource: .accent)
    
    return setSwitch
  }()
  
  private let timeSetStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    
    return stackView
  }()
  
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
  
  private let cancelButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("취소", for: .normal)
    button.titleLabel?.font = UIFont(name: AppFont.cafe24Font,
                                     size: UIFont.buttonFontSize)
    button.configuration = .tinted()
    button.tintColor = .gray
    
    return button
  }()
  
  // TODO: - title 색상 사용자 테마 색으로 적용
  private let saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("저장", for: .normal)
    button.titleLabel?.font = UIFont(name: AppFont.cafe24Font,
                                     size: UIFont.buttonFontSize)
    button.configuration = .tinted()
    button.setTitleColor( UIColor(resource: .accent), for: .normal)
    
    return button
  }()
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.spacing = 10
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private var halfStackView: UIStackView = {
    let stackView = UIStackView(frame: .zero)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 3
    stackView.alignment = .fill
    stackView.distribution = .equalCentering
    
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    firstSetting()
    configureUI()
    configureBackgroundColor()
    setUpAllConstraints()
    setUpTextViewMethod()
    pickerAndSwitchAddTarget()
    tapBottomButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Function
  private func setUpTextViewMethod() {
    todoTextView.delegate = self
  }
  
  private func firstSetting() {
    timeLabel.text = "시간 없음"
    timeSetSwitch.isOn = false
    txtCountLabel.text = String(todoTextView.text.count)
    timeSetDatePicker.isHidden = timeSetSwitch.isOn ? false : true
    todoTextView.becomeFirstResponder()
  }
  
  private func pickerAndSwitchAddTarget() {
    timeSetDatePicker.addTarget(self,
                                action: #selector(isTimeChange),
                                for: .valueChanged)
    timeSetSwitch.addTarget(self,
                            action: #selector(isSwitchChange),
                            for: .valueChanged)
  }
  
  @objc
  private func isTimeChange(_ sender: UIDatePicker) {
    timeLabel.text = dateFormat(sender.date)
  }
  
  private func dateFormat(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.dateFormat = "a h시 mm분"
    
    return formatter.string(from: date)
  }
  
  @objc
  private func isSwitchChange(_ sender: UISwitch) {
    if sender.isOn {
      timeSetDatePicker.isHidden = false
      timeLabel.text = dateFormat(timeSetDatePicker.date)
    } else {
      timeSetDatePicker.isHidden = true
      timeLabel.text = "시간 없음"
    }
  }
  
  private func tapBottomButton() {
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
    [timeLabel, todoTextView, txtCountLabel, timeSetStackView]
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
    txtCountLabel.text = txtCount
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      todoTextView.resignFirstResponder()
    }
    return true
  }
}
