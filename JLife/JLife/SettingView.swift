//
//  SettingView.swift
//  JLife
//
//  Created by OoO on 5/8/24.
//

import UIKit

final class SettingView: UIView {
  
  // MARK: - Components
  private let titleLabel: UILabel = TitleLabel(for: "달력 색상 변경")
  
  private var themeImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: CalendarColorPalette.basic.rawValue)
    
    return imageView
  }()
  
  private let themePickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.backgroundColor = .clear
    
    return pickerView
  }()
  
  private let nowThemeLabel: UILabel = BodyLabel(for: NameSpace.Notice.nowTheme + (AppColor.shared.theme?.kr ?? CalendarColorPalette.basic.theme.kr))
  
  private let applyButton: UIButton = TintedButton(title: "적용", color: UIColor(resource: .accent))
  
  private var fullStackView: UIStackView = VerticalFillStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
    configureBackgroundColor()
    setUpAllConstraints()
    setUpPickerViewMethods()
    tapApplyButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Function
  private func tapApplyButton() {
    applyButton.addTarget(self, action: #selector(notificationTapApplyButton), for: .touchUpInside)
  }
  
  @objc
  private func notificationTapApplyButton() {
    NotificationCenter.default.post(name: NSNotification.Name("tapApplyButton"), object: nil)
  }
  
  private func setUpPickerViewMethods() {
    themePickerView.delegate = self
    themePickerView.dataSource = self
  }
  
  // MARK: - Configure UI
  private func configureBackgroundColor() {
    backgroundColor = UIColor(resource: .background)
  }
  
  private func configureUI() {
    addSubview(fullStackView)
    [titleLabel, themeImageView, themePickerView, nowThemeLabel, applyButton]
      .forEach {fullStackView.addArrangedSubview($0)}
  }
  
  // MARK: - Constraints
  private func setUpAllConstraints() {
    setUpThemeImageViewConstraints()
    setUpThemePickerViewConstraints()
    setUpFullStackViewConstraints()
  }
  
  private func setUpFullStackViewConstraints() {
    NSLayoutConstraint.activate([
      fullStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      fullStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      fullStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.6),
      fullStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.9)
    ])
  }
  
  private func setUpThemeImageViewConstraints() {
    themeImageView.heightAnchor.constraint(equalTo: themeImageView.widthAnchor, multiplier: 1).isActive = true
  }
  
  private func setUpThemePickerViewConstraints() {
    themePickerView.heightAnchor.constraint(equalTo: themePickerView.widthAnchor, multiplier: 0.5).isActive = true
  }
}
// MARK: - Extension SettingView
extension SettingView: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return CalendarColorPalette.allCases.count
  }
  
  // TODO: - 선택한 테마 값 넘기는 작업
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    themeImageView.image = UIImage(named: String(describing: CalendarColorPalette.allCases[row]))
    nowThemeLabel.text = NameSpace.Notice.nowTheme + CalendarColorPalette.allCases[row].theme.kr
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label = UILabel()
    if let labelView = view {
      label = labelView as? UILabel ?? UILabel()
    }
    label.textAlignment = .center
    label.adjustsFontForContentSizeCategory = true
    label.text = CalendarColorPalette.allCases[row].theme.kr
    label.font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                          of: FontSize.body1.size,
                                          for: .body)
    
    return label
  }
}
