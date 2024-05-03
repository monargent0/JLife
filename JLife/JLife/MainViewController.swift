//
//  MainViewController.swift
//  JLife
//
//  Created by OoO on 2023/06/22.
//

import UIKit
//import SQLite3

final class MainViewController: UIViewController {
    
    // MARK: 변수 선언
    let launchLogoGifView = LogoGifView(frame: .zero)
    private let mainCalendarView = MainCalendarView(frame: .zero)
//    var presentDate = Date() // 달력 생성용
//    var todayDate = Date() // 오늘 표시
//    var allDateItems: [String] = [] // 달력 cell items
//    var items: (daysInMonth : Int , startWeekDay : Int) = (0,0) //
//    var monthlyExistence = false
//    var noNowMonthIndex: [Int] = []
//    let monthlyNotice = "Monthly Box를 자유롭게 채워보세요!"
//    let colorNameList = ColorTheme().colorName
//    let defaultsTheme = UserDefaults.standard // UserDefaults
//    var nowTheme: String = "Basic" // 사용자 설정 테마
//    
//    // MARK: Monthly SQLite
//    var monthlyBundle: [Monthly] = []
//    var scoreData:[TotalScore] = []
//    var db: OpaquePointer? // DB포인터
//
    // MARK: - LoadView()
    override func loadView() {
        view = mainCalendarView
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(disappearLogoGifView),
                                               name: NSNotification.Name("isGifDone"),
                                               object: nil)
    }
    
    @objc
    private func disappearLogoGifView() {
        launchLogoGifView.removeFromSuperview()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //
//        cvCalendar.dataSource = self
//        cvCalendar.delegate = self
//        // 달력 구성
//        setMonth(presentDate)
//        // SQL 구성
//        Task{
//            try await readMonthlyValues()
//        }
////        createMonthlyTable()
//        // 오늘 버튼 초기세팅
//        todayButton.isEnabled = false
//        // Collection View Size
//        cvCalendar.translatesAutoresizingMaskIntoConstraints = false // 스토리보드에서 적용한것 무시
////        cvCalendar.widthAnchor.constraint(equalToConstant: deviceWidth()).isActive = true // 가로
////        cvCalendar.heightAnchor.constraint(equalToConstant: ceil((deviceWidth()/7)*6)+2 ).isActive = true // 세로
//        cvCalendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // 가로 중앙 정렬
//        cvCalendar.topAnchor.constraint(equalTo:svWeek.bottomAnchor, constant: 10).isActive = true // 세로 위치
//        cvCalendar.isScrollEnabled = false
//        tvMContent.translatesAutoresizingMaskIntoConstraints = false
//        tvMContent.heightAnchor.constraint(equalToConstant: deviceSize()).isActive = true
//        //
//        makeSwipe()
//        view.snapshotView(afterScreenUpdates: true)
//    }//
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(launchLogoGifView)
        launchLogoGifView.frame = view.bounds
    }
    
//    // Will Appear
//    override func viewWillAppear(_ animated: Bool) {
//        // userDefaults 테마 설정 값
//        nowTheme = defaultsTheme.string(forKey: "theme") ?? "Basic"
//        if monthlyExistence == true{
//            lblMonthlyTitle.text = monthlyBundle[0].title
//            tvMContent.text = monthlyBundle[0].content
//        }
//        Task{
//            try await readTotalScoreValues()
//            cvCalendar.reloadData()
//        }
//        // Backgroung - Foreground
//        NotificationCenter.default.addObserver(self, selector: #selector(enterForegroundUpdateToday), name: UIApplication.willEnterForegroundNotification, object: nil)
//    }//
//    
//    // MARK: 버튼 연결
//    @IBAction func btnPrevMonth(_ sender: UIButton) {
//        presentDate = CalendarBuilder().minusMonth(date: presentDate)
//        setMonth(presentDate)
//        Task{
//            try await readMonthlyValues()
//            try await readTotalScoreValues()
//        }
//        if presentDate != todayDate{
//            todayButton.isEnabled = true
//        }else{
//            todayButton.isEnabled = false
//        }
//    }//
//    
//    @IBAction func btnNextMonth(_ sender: UIButton) {
//        presentDate = CalendarBuilder().plusMonth(date: presentDate)
//        setMonth(presentDate)
//        Task{
//            try await readMonthlyValues()
//            try await readTotalScoreValues()
//            
//        }
//        if presentDate != todayDate{
//            todayButton.isEnabled = true
//        }else{
//            todayButton.isEnabled = false
//        }
//    }//
//    
//    @IBAction func btnToday(_ sender: UIBarButtonItem) {
//        presentDate = todayDate
//        setMonth(presentDate)
//        Task{
//            try await readMonthlyValues()
//            try await readTotalScoreValues()
//        }
//        if presentDate != todayDate{
//            todayButton.isEnabled = true
//        }else{
//            todayButton.isEnabled = false
//        }
//    }//
//    
//    // MARK: Foregroung - Background Function
//    @objc func enterForegroundUpdateToday() {
//        todayDate = Date() // 백그라운드에서 포어그라운드로 올 시
//        presentDate = todayDate
//        setMonth(presentDate)
//        Task{
//            try await readMonthlyValues()
//            try await readTotalScoreValues()
//            cvCalendar.reloadData()
//        }
//        if presentDate != todayDate{
//            todayButton.isEnabled = true
//        }else{
//            todayButton.isEnabled = false
//        }
//        // 굳이 옵저버 삭제 안해도 된다. 백그라운드에서 포어로 돌아올때 오늘 날짜 업데이트 되는지 확인하기!
////        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
//        }//
//
//    // MARK: Setting Calendar Function
//    private func setMonth(_ date:Date){
//        // Properties
//        allDateItems.removeAll() // 초기화
//        items.daysInMonth = CalendarBuilder().daysInMonth(date: date) // 현재 달 일수
//        let firstOfMonth = CalendarBuilder().firstOfMonth(date: date) // 월의 첫날
//        items.startWeekDay = CalendarBuilder().startWeekDay(date: firstOfMonth) // 달 시작 요일
//        let daysInPrevMonth = CalendarBuilder().daysInPrevMonth(date: date) // 이전 달 일수
//        
//        // Calendar Contents
//        var count:Int = 1
//        while(count <= 42){ // 7 days 6 week
//            if(count <= items.startWeekDay){ // 이전 달
//                allDateItems.append(String(daysInPrevMonth - items.startWeekDay + count))
//            }else if(count - items.startWeekDay > items.daysInMonth){ // 다음 달
//                allDateItems.append(String(count % (items.daysInMonth + items.startWeekDay)))
//            }else{ // 현재 달
//                allDateItems.append(String(count - items.startWeekDay))
//            }
//            count += 1
//        } // while
//        
//        // Title
//        lblDateTitle.text = CalendarBuilder().yearString(date: date) + "년 " + CalendarBuilder().monthString(date: date) + "월"
//        
//        // CollectionView Reload
//        cvCalendar.reloadData()
//    }// Func setMonth
//    
//    // MARK: SQLite 테이블 생성
//    private func createMonthlyTable() async throws {
//        // Monthly
//        if #available(iOS 16.0, *) {
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "MonthlyData.sqlite")
//            if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        } else {
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MonthlyData.sqlite")
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }
//        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS monthly (mid INTEGER PRIMARY KEY AUTOINCREMENT, myear TEXT, mmonth TEXT, mtitle TEXT, mcontent TEXT)", nil, nil, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error creating monthly table \(errmsg)")
//            return
//        }else{
////            print("create monthly ok")
//        }
//    }//Monthly
//    
//    private func createTotalScoreTable() async throws{
//        // TotalScore
//        if #available(iOS 16.0, *) {
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TotalScore.sqlite")
//            if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
//                //            print("error opening TotalScore DB")
//            }
//        } else{
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TotalScore.sqlite")
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }
//        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS totalscore (sid INTEGER PRIMARY KEY AUTOINCREMENT, sdate TEXT, sday TEXT, stotal INTEGER)", nil, nil, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error creating TotalScore table \(errmsg)")
//            return
//        }
//    }//TotalScore
//    
//    // MARK: SQLite 테이블 불러오기
//    private func readMonthlyValues() async throws{
//        try await createMonthlyTable()
//        monthlyBundle.removeAll()
//        defer{
//            sqlite3_close(db)
//        }
//        let queryString = "SELECT mid, mtitle, mcontent FROM monthly WHERE myear = ? and mmonth = ?;"
//        var stmt : OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let date = lblDateTitle.text?.components(separatedBy: " ")
//        let year = date![0]
//        let month = date![1]
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing select : \(errmsg)")
//            return
//        }
//        sqlite3_bind_text(stmt, 1, year, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, month, -1, SQLITE_TRANSIENT)
//        
////        print("sqlite row ",SQLITE_ROW)
//        if sqlite3_step(stmt) == SQLITE_ROW{
//            // DB 있는 경우
//            let id = sqlite3_column_int(stmt, 0)
//            let title = String(cString: sqlite3_column_text(stmt, 1))
//            let content = String(cString: sqlite3_column_text(stmt, 2))
////            print(id, title, content)
//            monthlyBundle.append(Monthly(id: Int(id), title: title, content: content))
//            
//            monthlyExistence = true
//            self.lblMonthlyTitle.text = title
//            self.tvMContent.text = content
//            self.tvMContent.textColor = UIColor(named: "TextColor") // textview 글자색
//        }else{
////            print("no db Data")
//            monthlyExistence = false
//            self.lblMonthlyTitle.text = "#Monthly"
//            self.tvMContent.text = monthlyNotice
//            self.tvMContent.textColor = UIColor(named: "AccentColor") // textview 글자색
//        }
//        
//        sqlite3_finalize(stmt)
//
//    }//readMonthlyValues
//    
//    // MARK: total score Read
//    private func readTotalScoreValues() async throws{
//        try await createTotalScoreTable()
//        scoreData.removeAll()
//        defer{
//            sqlite3_close(db)
//        }
//        let queryString = "SELECT sid, stotal, sday FROM totalscore WHERE sdate = ?"
//        var stmt : OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let date = lblDateTitle.text
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing total select : \(errmsg)")
//            return
//        }
//        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
//        
//        while(sqlite3_step(stmt) == SQLITE_ROW){
//            // DB 있는 경우
//            let id = sqlite3_column_int(stmt, 0)
//            let total = sqlite3_column_int(stmt, 1)
//            let day = String(cString: sqlite3_column_text(stmt, 2))
////            print("\(id),요일 \(day), 점수 \(total) ")
//            scoreData.append(TotalScore(id: Int(id) , date: date, day: day, score: Int(total)))
//            
//        }
//        cvCalendar.reloadData()
//        sqlite3_finalize(stmt)
//
//    }//readMonthlyValues
//    
//    // MARK: 아이폰 모델에 따라 Collection View 사이즈 조정 Function
//    private func deviceSize() -> CGFloat {
////        let deviceName = UIDevice.current.name // ios16부터 디테일한모델명 제공안함
//        let screenHeight = UIScreen.main.bounds.size.height
//        var height : CGFloat
//        
//        switch screenHeight {
//        case 480 : //"iPhone 3gs","iPhone 4","iPhone 4s": // 320 , 480
//            height = 80
//        case 568: //"iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320 568
//            height = 80
//        case 667://"iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone SE (2nd generation)", "iPhone SE (3rd generation)": // 375 667 - ios15
//            height = 95
//        case 812://"iPhone 12 mini","iPhone 13 mini","iPhone X","iPhone Xs","iPhone 11 Pro" : // 375 812
//            height = 180
//        case 844://"iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14": // 390 844
//            height = 200
//        case 852://"iPhone 14 Pro": // 393 852
//            height = 200
//        case 736://"iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus": // 414 736
//            height = 135
//        case 896://"iPhone Xʀ","iPhone 11", "iPhone Xs Max","iPhone 11 Pro Max": // 414 896
//            height = 225
//        case 926://"iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus": // 428 926
//            height = 245
//        case 932://"iPhone 14 Pro Max" : // 430 932
//            height = 250
//        default : //
//            height = round(screenHeight / 5)
//        }
//        return height
//    }// Func device
//    
//    // MARK: segue MonthlyView로 값 보내기
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let monthlyPopUpViewController = segue.destination as? MonthlyPopUpViewController
//        let dailyViewController = segue.destination as? DailyViewController
//        let date = lblDateTitle.text?.components(separatedBy: " ")
//        
//        if segue.identifier == "sgMonthly"{
//            monthlyPopUpViewController?.year = date![0]
//            monthlyPopUpViewController?.month = date![1]
//            monthlyPopUpViewController?.mvTitle = lblMonthlyTitle.text!
//            monthlyPopUpViewController?.mvContent = tvMContent.text == monthlyNotice ? "" : tvMContent.text
//            monthlyPopUpViewController?.existence = monthlyExistence // DB select 존재 여부
//            monthlyPopUpViewController?.monthlyID = monthlyBundle.isEmpty ? 0 : monthlyBundle[0].id
//            // modal dismiss notification - 월별목표View
//            NotificationCenter.default.addObserver(self, selector: #selector(didDismissMonthlyNotification(_ :)), name: Notification.Name("DidDismissMonthlyViewController"), object: nil)
//        }else if segue.identifier == "sgDay"{
//            let cell = sender as! UICollectionViewCell
//            let indexPath = self.cvCalendar.indexPath(for: cell)
//            var sid = 0
//            dailyViewController?.mvYear = Int(date![0].prefix(upTo:date![0].index(before: date![0].endIndex)))!
//            dailyViewController?.mvMonth = Int(date![1].prefix(upTo:date![1].index(before: date![1].endIndex)))!
//            dailyViewController?.mvDay = Int(allDateItems[indexPath!.row])!
//    
//            for data in scoreData{
//                if data.day == allDateItems[indexPath!.row] {
//                    sid = data.id!
//                    break
//                }else{
//                    sid = 0
//                }
//            }
//            dailyViewController?.scoreID = sid
//        }
//        
//    }// prepare
//
//    // MARK: DISMISS 후 화면 재로딩
//    @objc
//    private func didDismissMonthlyNotification(_ notification:Notification) {
//        Task{
//            try await readMonthlyValues()
//            // modal dismiss notification Remove - 월별목표View
//            NotificationCenter.default.removeObserver(self, name: Notification.Name("DidDismissMonthlyViewController"), object: nil)
//        }
//        if monthlyExistence == true{
//            lblMonthlyTitle.text = monthlyBundle[0].title
//            tvMContent.text = monthlyBundle[0].content
//        }
//    }//
//
//    //MARK: 달력 스와이프 제스쳐
//    func makeSwipe() {
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.respondToSwipeGesture(_ :)))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.cvCalendar.addGestureRecognizer(swipeLeft)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.respondToSwipeGesture(_ :)))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.cvCalendar.addGestureRecognizer(swipeRight)
//        
//    }
//    
//    @objc func respondToSwipeGesture(_ gesture:UIGestureRecognizer){
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
//            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.left{
//                // 다음달
//                presentDate = CalendarBuilder().plusMonth(date: presentDate)
//                setMonth(presentDate)
//                Task{
//                    try await readMonthlyValues()
//                    try await readTotalScoreValues()
//                }
//                if presentDate != todayDate{
//                    todayButton.isEnabled = true
//                }else{
//                    todayButton.isEnabled = false
//                }
//            }else if swipeGesture.direction == UISwipeGestureRecognizer.Direction.right{
//                // 이전달
//                presentDate = CalendarBuilder().minusMonth(date: presentDate)
//                setMonth(presentDate)
//                Task{
//                    try await readMonthlyValues()
//                    try await readTotalScoreValues()
//                }
//                if presentDate != todayDate{
//                    todayButton.isEnabled = true
//                }else{
//                    todayButton.isEnabled = false
//                }
//            }
//        }
//    }
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//} //MainViewController
//
//// MARK:  Collection View 구성 Extension
///* Collection View Cell */
//extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource{
//    // Cell 개수
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        allDateItems.count
//    }
//    // Cell 구성
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarCell
//        // Date
//        cell.lblDay.text = allDateItems[indexPath.row]
//        // Font Color
//        switch indexPath.row {
//        case 0..<items.startWeekDay:
//            cell.lblDay.textColor = .lightGray
//            cell.isUserInteractionEnabled = false // cell 선택 비활성화
//        case (items.daysInMonth + items.startWeekDay)..<allDateItems.count:
//            cell.lblDay.textColor = .lightGray
//            cell.isUserInteractionEnabled = false
//        default:
//            for score in scoreData{
//                if score.day == allDateItems[indexPath.row]{ // Color Theme 변경 위치
//                    cell.backgroundColor = UIColor(named: colorNameList[nowTheme]!.mainColor )?.withAlphaComponent(CGFloat(Double(score.score!) / 100.0))
//                    if Double(score.score!) / 100.0 == 1.0 {
//                       cell.layer.borderColor = UIColor(named: colorNameList[nowTheme]!.border )?.cgColor
//                    }
//                }
//            }
//            cell.lblDay.textColor = UIColor(named: "TextColor")
//            cell.isUserInteractionEnabled = true
//        }
//        // Today 표시
//        if cell.lblDay.text == CalendarBuilder().dayString(date: todayDate) &&  CalendarBuilder().monthString(date: todayDate) == CalendarBuilder().monthString(date: presentDate) && cell.lblDay.textColor == UIColor(named: "TextColor"){
//            cell.lblToday.isHidden = false
//        }
//        return cell
//    }
//
//}// Delegate, DataSouce
//
//extension MainViewController:UICollectionViewDelegateFlowLayout{
//    // 위아래 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    // 좌우 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    // Cell 크기
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = round((collectionView.frame.size.width) / 7 - 1)
//        let size = CGSize(width: width, height: width)
//        return size
//    }
//    //
//    
}// DelegateFlowLayout

