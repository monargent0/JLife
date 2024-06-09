//
//  MainCalendarView.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//

import UIKit

final class MainCalendarView: UIView {
  
  private let buttonStackView: UIStackView = HorizontalStackView()
  private let settingButton: UIButton = ImageButton(with: NameSpace.Image.settingIcon)
  private let searchingButton: UIButton = ImageButton(with: NameSpace.Image.searchingIcon)
  private let monthlyStackView: UIStackView = HorizontalStackView()
  private let previousMonthButton: UIButton = ImageButton(with: NameSpace.Image.previousIcon)
  
  private let currentMonthLabel: UILabel = {
    let label = UILabel()
    label.text = "TEST MONTH"
    label.textColor = UIColor(resource: .reversedSystem)
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                          of: FontSize.headline3.size,
                                          for: .headline)
    
    return label
  }()
  
  private let nextMonthButton: UIButton = ImageButton(with: NameSpace.Image.nextIcon)
  private let firstSeparatorView: UIView = SeparatorView()
  
  // MARK: - Week Labels
  private let daysOfWeekStackView: UIStackView = HorizontalStackView()
  private let sundayLabel: UILabel = BodyLabel(for: NameSpace.DayText.sunday)
  private let mondayLabel: UILabel = BodyLabel(for: NameSpace.DayText.monday)
  private let tuesdayLabel: UILabel = BodyLabel(for: NameSpace.DayText.tuesday)
  private let wednesdayLabel: UILabel = BodyLabel(for: NameSpace.DayText.wednesday)
  private let thursdayLabel: UILabel = BodyLabel(for: NameSpace.DayText.thursday)
  private let fridayLabel: UILabel = BodyLabel(for: NameSpace.DayText.friday)
  private let saturdayLabel: UILabel = BodyLabel(for: NameSpace.DayText.saturday)
  
  private let compositionalLayout: UICollectionViewCompositionalLayout = {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
    
    listConfiguration.separatorConfiguration.bottomSeparatorInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    let compositionalLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    return compositionalLayout
  }()
  
  private lazy var calendarCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
    
    return collectionView
  }()
  
  private let monthlyBoxTotalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    return stackView
  }()
  
  private let secondSeparatorView: UIView = SeparatorView()
  
  private let monthlyBoxTopStackView: UIStackView = HorizontalStackView()
  
  private let monthlyBoxTitleLabel: UILabel = TitleLabel(for: NameSpace.Notice.monthlyBoxTitle)

  private let plusButton: UIButton = ImageButton(with: NameSpace.Image.plusIcon)
  
  private let monthlyBoxDetailLabel: UILabel = {
    let label = UILabel()
    label.text = NameSpace.Notice.monthlyBoxDetail
    label.textAlignment = .left
    label.numberOfLines = 0
    label.textColor = label.text == NameSpace.Notice.monthlyBoxDetail ?
    UIColor(named: AppColor.shared.theme?.mainColor ?? CalendarColorPalette.basic.theme.mainColor) :
    UIColor(resource: .reversedSystem)
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFontMetrics.customFont(with: AppFont.shared.style,
                                          of: FontSize.body1.size,
                                          for: .title3)
    
    return label
  }()
  
  private let thirdSeparatorView: UIView = SeparatorView()
  
  // MARK: - Intializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureBackgroundColor()
    configureUI()
    setUpAllConstraints()
    tapNavBarButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private Function
  private func tapNavBarButton() {
    settingButton.addTarget( self, action: #selector(tappedSettingButton), for: .touchUpInside)
    searchingButton.addTarget( self, action: #selector(tappedSearchingButton), for: .touchUpInside)
  }
  
  @objc
  private func tappedSettingButton() {
    NotificationCenter.default.post(name: NSNotification.Name("tappedSettingButton"), object: nil)
  }
  
  @objc
  private func tappedSearchingButton() {
    NotificationCenter.default.post(name: NSNotification.Name("tappedSearchingButton"), object: nil)
  }
  
  // MARK: - Configure UI
  private func configureBackgroundColor() {
    backgroundColor = .systemBackground
  }
  
  private func configureUI() {
    [buttonStackView, monthlyStackView, firstSeparatorView, daysOfWeekStackView, calendarCollectionView, secondSeparatorView, monthlyBoxTotalStackView, thirdSeparatorView]
      .forEach { addSubview($0) }
    [settingButton, searchingButton]
      .forEach { buttonStackView.addArrangedSubview($0) }
    [previousMonthButton, currentMonthLabel, nextMonthButton]
      .forEach { monthlyStackView.addArrangedSubview($0) }
    [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel]
      .forEach { daysOfWeekStackView.addArrangedSubview($0) }
    [monthlyBoxTopStackView, monthlyBoxDetailLabel]
      .forEach { monthlyBoxTotalStackView.addArrangedSubview($0) }
    [monthlyBoxTitleLabel, plusButton]
      .forEach { monthlyBoxTopStackView.addArrangedSubview($0)}
  }
  
  // MARK: - Constraints
  private func setUpAllConstraints() {
    setUpButtonStackViewConstraints()
    setUpMonthlyStackViewConstraints()
    setUpFirstSeparatorViewConstraints()
    setUpDaysOfWeekStackView()
    //    setUpCalendarCollectionView()
    setUpSecondSeparatorViewConstraints()
    setUpMonthlyBoxTotalStackView()
    setUpMonthlyBoxTopStackView()
    setUpMonthlyBoxDetailLabel()
    setUpThirdSeparatorViewConstraints()
  }
  
  private func setUpButtonStackViewConstraints() {
    NSLayoutConstraint.activate([
      buttonStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                             multiplier: 0.95),
      buttonStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      buttonStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                           constant: 12)
    ])
  }
  
  private func setUpMonthlyStackViewConstraints() {
    NSLayoutConstraint.activate([
      monthlyStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                              multiplier: 0.6),
      monthlyStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      monthlyStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor,
                                            constant: 10)
    ])
  }
  
  private func setUpFirstSeparatorViewConstraints() {
    NSLayoutConstraint.activate([
      firstSeparatorView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                multiplier: 0.95),
      firstSeparatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      firstSeparatorView.topAnchor.constraint(equalTo: monthlyStackView.bottomAnchor,
                                              constant: 8),
      firstSeparatorView.heightAnchor.constraint(equalToConstant: 2)
    ])
  }
  
  private func setUpDaysOfWeekStackView() {
    NSLayoutConstraint.activate([
      daysOfWeekStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                 multiplier: 0.85),
      daysOfWeekStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      daysOfWeekStackView.topAnchor.constraint(equalTo: firstSeparatorView.bottomAnchor,
                                               constant: 8)
    ])
  }
  
  private func setUpCalendarCollectionView() {
    NSLayoutConstraint.activate([
      calendarCollectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                    multiplier: 0.85),
      calendarCollectionView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      calendarCollectionView.topAnchor.constraint(equalTo: daysOfWeekStackView.bottomAnchor,
                                                  constant: 8)
    ])
  }
  
  private func setUpSecondSeparatorViewConstraints() {
    NSLayoutConstraint.activate([
      secondSeparatorView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                 multiplier: 0.95),
      secondSeparatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      secondSeparatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: -200),
      secondSeparatorView.heightAnchor.constraint(equalToConstant: 2)
    ])
  }
  
  private func setUpMonthlyBoxTotalStackView() {
    NSLayoutConstraint.activate([
      monthlyBoxTotalStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                      multiplier: 0.85),
      monthlyBoxTotalStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      monthlyBoxTotalStackView.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor,
                                                    constant: 8)
    ])
  }
  
  private func setUpMonthlyBoxTopStackView() {
    NSLayoutConstraint.activate([
      monthlyBoxTopStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                    multiplier: 0.85),
      monthlyBoxTopStackView.topAnchor.constraint(equalTo: monthlyBoxTotalStackView.topAnchor)
    ])
  }
  
  private func setUpMonthlyBoxDetailLabel() {
    NSLayoutConstraint.activate([
      monthlyBoxDetailLabel.topAnchor.constraint(equalTo: monthlyBoxTitleLabel.bottomAnchor,
                                                 constant: 8),
      monthlyBoxDetailLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                   multiplier: 0.85)
    ])
  }
  
  private func setUpThirdSeparatorViewConstraints() {
    NSLayoutConstraint.activate([
      thirdSeparatorView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor,
                                                multiplier: 0.95),
      thirdSeparatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      thirdSeparatorView.heightAnchor.constraint(equalToConstant: 2),
      thirdSeparatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -2)
    ])
  }
}
