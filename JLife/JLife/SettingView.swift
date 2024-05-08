//
//  SettingView.swift
//  JLife
//
//  Created by OoO on 5/8/24.
//

import UIKit

final class SettingView: UIView {

    private let assetsNameList = ["Basic", "Beige", "Blue", "CoolGray", "Coral", "Green", "Pink", "Purple", "WarmGray", "Yellow"]
    
    // MARK: - Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        let customFont = UIFont(name: "Cafe24Ssurroundair", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "달력 색상 변경"
        label.textAlignment = .center
        label.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont!)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(resource: .reversedSystem)
        
        return label
    }()
    
    private var themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Basic")
    
        return imageView
    }()
    
    private let themePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .clear
        
        return pickerView
    }()
    
    private var themeStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private let nowThemeLabel: UILabel = {
        let label = UILabel()
        let customFont =  UIFont(name: "Cafe24Ssurroundair", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재 테마 색상: (-)" // 현재 테마 받아와서 넣어야함 / 기존방식: userdefaults
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont!)
        label.textColor = UIColor(resource: .reversedSystem)
        
        return label
    }()
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("적용", for: .normal)
        button.titleLabel?.font = UIFont(name: "Cafe24Ssurroundair", size: 17)
        button.configuration = .tinted()
        button.setTitleColor( UIColor(resource: .accent), for: .normal)
        
        return button
    }()
    
    // MARK: - Intializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpBackgroundColor()
        configureUI()
        setUpAllConstraints()
        
        themePickerView.delegate = self
        themePickerView.dataSource = self
        
        applyButton.addTarget(self, action: #selector(touchApplyButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func touchApplyButton() {
         NotificationCenter.default.post(name: NSNotification.Name("touchApplyButton"), object: nil)
    }
    
    // MARK: - Configure UI
    private func setUpBackgroundColor() {
        backgroundColor = UIColor(resource: .background)
    }
    
    private func configureUI() {
        addSubview(titleLabel)
        addSubview(nowThemeLabel)
        addSubview(themeStackView)
        [themeImageView, themePickerView]
            .forEach {themeStackView.addArrangedSubview($0)}
        addSubview(applyButton)
    }
    
    // MARK: - Constraints
    private func setUpAllConstraints() {
        setUpTitleLabelConstraints()
        setUpThemeImageViewConstraints()
        setUpThemePickerViewConstraints()
        setUpThemeStackViewConstraints()
        setUpNowThemeLabelConstraints()
        setUpApplyButtonConstraints()
    }
    
    private func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpThemeImageViewConstraints() {
        themeImageView.heightAnchor.constraint(equalTo: themeImageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setUpThemePickerViewConstraints() {
        themePickerView.heightAnchor.constraint(equalTo: themePickerView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setUpThemeStackViewConstraints() {
        NSLayoutConstraint.activate([
            themeStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            themeStackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            themeStackView.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.lastBaselineAnchor, constant: 20),
            themeStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            themeStackView.heightAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setUpNowThemeLabelConstraints() {
        NSLayoutConstraint.activate([
            nowThemeLabel.bottomAnchor.constraint(equalTo: applyButton.topAnchor, constant: -20),
            nowThemeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nowThemeLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpApplyButtonConstraints() {
        NSLayoutConstraint.activate([
            applyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            applyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
} // SettingView
// MARK: - Pickerview Delegate, DataSource
extension SettingView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerview: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return assetsNameList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        themeImageView.image = UIImage(named: assetsNameList[row] )
//        selectColor = colorList[row] // 선택한 테마 값 할당
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var label = UILabel()
            if let labelView = view {
                label = labelView as! UILabel
            }
            label.font = UIFont(name: "Cafe24Ssurroundair", size: 17)
            label.text = assetsNameList[row] // 한글로 변환 해야할지?
            label.textAlignment = .center
            return label
        }
    
} // extension
