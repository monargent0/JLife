//
//  MainCalendarView.swift
//  JLife
//
//  Created by OoO on 5/1/24.
//

import UIKit

final class MainCalendarView: UIView {
  
  private let buttonStackView: UIStackView = HorizontalStackView()
  private let settingButton: UIButton = ImageButton(with: "gearshape.fill")
  private let searchingButton: UIButton = ImageButton(with: "magnifyingglass")
  private let monthlyStackView: UIStackView = HorizontalStackView()
  private let previousMonthButton: UIButton = ImageButton(with: "chevron.left")
  
  private let currentMonthLabel: UILabel = {
    let label = UILabel()
    label.text = "TEST MONTH"
    label.textColor = UIColor(resource: .reversedSystem)
    
    return label
  }()
  
  private let nextMonthButton: UIButton = ImageButton(with: "chevron.right")
  private let firstSeparatorView: UIView = SeparatorView()
  
  // MARK: - Week Labels
  private let daysOfWeekStackView: UIStackView = HorizontalStackView()
  private let sundayLabel: UILabel = DayLabel(for: "일")
  private let mondayLabel: UILabel = DayLabel(for: "월")
  private let tuesdayLabel: UILabel = DayLabel(for: "화")
  private let wednesdayLabel: UILabel = DayLabel(for: "수")
  private let thursdayLabel: UILabel = DayLabel(for: "목")
  private let fridayLabel: UILabel = DayLabel(for: "금")
  private let saturdayLabel: UILabel = DayLabel(for: "토")
  
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
    [buttonStackView, monthlyStackView, firstSeparatorView, daysOfWeekStackView]
      .forEach { addSubview($0) }
    [settingButton, searchingButton]
      .forEach { buttonStackView.addArrangedSubview($0) }
    [previousMonthButton, currentMonthLabel, nextMonthButton]
      .forEach { monthlyStackView.addArrangedSubview($0) }
    [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel]
      .forEach { daysOfWeekStackView.addArrangedSubview($0) }
  }
  
  // MARK: - Constraints
  private func setUpAllConstraints() {
    setUpButtonStackViewConstraints()
    setUpMonthlyStackViewConstraints()
    setUpFirstSeparatorViewConstraints()
    setUpDaysOfWeekStackView()
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
}
