//
//  MainViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit
import SQLite3 /**/

class MainViewController: UIViewController {

    // MARK: 스토리보드와 연결
    @IBOutlet weak var cvCalendar: UICollectionView! // 달력
    @IBOutlet weak var lblDateTitle: UILabel! // 상단 년월
    @IBOutlet weak var tvMContent: UITextView!
    @IBOutlet weak var svWeek: UIStackView! // 상단 요일
    @IBOutlet weak var lblMonthlyTitle: UILabel!
    
    // MARK: 변수 선언
    var presentDate = Date() // 달력 생성용
    let todayDate = Date() // 오늘 표시
    var allDateItems : [String] = [] // 달력 cell items
    var items : (daysInMonth : Int , startWeekDay : Int) = (0,0) //
    var monthlyExistence = false
    var noNowMonthIndex:[Int] = []
    
    // MARK: Monthly SQLite
    var monthlyBundle: [Monthly] = []
    var db: OpaquePointer? // DB포인터
    
    // 임시 변수
    var content = ""
    
    // Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        cvCalendar.dataSource = self
        cvCalendar.delegate = self
        // 달력 구성
        setMonth(presentDate)
        // SQL 구성
        createMonthlyTable()
        
        // Collection View Size
        cvCalendar.translatesAutoresizingMaskIntoConstraints = false // 스토리보드에서 적용한것 무시
        cvCalendar.widthAnchor.constraint(equalToConstant: deviceWidth()).isActive = true // 가로
        cvCalendar.heightAnchor.constraint(equalToConstant: ceil((deviceWidth()/7)*6) ).isActive = true // 세로
        cvCalendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // 가로 중앙 정렬
        cvCalendar.topAnchor.constraint(equalTo:svWeek.bottomAnchor, constant: 10).isActive = true // 세로 위치
        // Month Content placeholder
        if content.isEmpty {
            tvMContent.text = "+ 버튼을 눌러보세요!"
            tvMContent.textColor = UIColor(named: "AccentColor")
        }else{
            tvMContent.textColor = UIColor.black
        }
        // modal dismiss notification
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissMonthlyNotification(_ :)), name: Notification.Name("DidDismissMonthlyViewController"), object: nil)
    }
    // Will Appear
    override func viewWillAppear(_ animated: Bool) {
        // 달력 달성도 색 표시 reloadview
        readMonthlyValues()
        
        if monthlyExistence == true{
            lblMonthlyTitle.text = monthlyBundle[0].title
            tvMContent.text = monthlyBundle[0].content
        }
    }
    
    // MARK: 버튼 연결
    @IBAction func btnPrevMonth(_ sender: UIButton) {
        presentDate = CalendarBuilder().minusMonth(date: presentDate)
        setMonth(presentDate)
        readMonthlyValues()
    }
    
    @IBAction func btnNextMonth(_ sender: UIButton) {
        presentDate = CalendarBuilder().plusMonth(date: presentDate)
        setMonth(presentDate)
        readMonthlyValues()
    }
       
    // MARK: Setting Calendar Function
    private func setMonth(_ date:Date){
        // Properties
        allDateItems.removeAll() // 초기화
        items.daysInMonth = CalendarBuilder().daysInMonth(date: date) // 현재 달 일수
        let firstOfMonth = CalendarBuilder().firstOfMonth(date: date) // 월의 첫날
        items.startWeekDay = CalendarBuilder().startWeekDay(date: firstOfMonth) // 달 시작 요일
        let daysInPrevMonth = CalendarBuilder().daysInPrevMonth(date: date) // 이전 달 일수
        
        // Calendar Contents
        var count:Int = 1
        while(count <= 42){ // 7 days 6 week
            if(count <= items.startWeekDay){ // 이전 달
                allDateItems.append(String(daysInPrevMonth - items.startWeekDay + count))
            }else if(count - items.startWeekDay > items.daysInMonth){ // 다음 달
                allDateItems.append(String(count % (items.daysInMonth + items.startWeekDay)))
            }else{ // 현재 달
                allDateItems.append(String(count - items.startWeekDay))
            }
            count += 1
        } // while
        
        // Title
        lblDateTitle.text = CalendarBuilder().yearString(date: date) + "년 " + CalendarBuilder().monthString(date: date) + "월"
        
        // CollectionView Reload
        cvCalendar.reloadData()
    }// Func setMonth
    
    // MARK: SQLite 테이블 생성
    private func createMonthlyTable(){
        // Monthly
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "MonthlyData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening monthly database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS monthly (mid INTEGER PRIMARY KEY AUTOINCREMENT, myear TEXT, mmonth TEXT, mtitle TEXT, mcontent TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating monthly table \(errmsg)")
            return
        }else{print("create monthly ok")}
    }//Monthly
    
    private func createTodoTable(){
        // TodoList
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoList.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening Todo DB")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todolist (tid INTEGER PRIMARY KEY AUTOINCREMENT, myear TEXT, mmonth TEXT, mtitle TEXT, mcontent TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating todo table \(errmsg)")
            return
        }
    }//TodoList
    
    // MARK: SQLite 테이블 불러오기
    func readMonthlyValues(){
        monthlyBundle.removeAll()
        let queryString = "SELECT mid,mtitle,mcontent FROM monthly WHERE myear = ? and mmonth = ?;"
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let date = lblDateTitle.text?.components(separatedBy: " ")
        let year = date![0]
        let month = date![1]
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing select : \(errmsg)")
            return
        }
        sqlite3_bind_text(stmt, 1, year, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, month, -1, SQLITE_TRANSIENT)
        
//        print("sqlite row ",SQLITE_ROW)
        if sqlite3_step(stmt) == SQLITE_ROW{
            // DB 있는 경우
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let content = String(cString: sqlite3_column_text(stmt, 2))
//            print(id, title, content)
            monthlyBundle.append(Monthly(id: Int(id), title: title, content: content))
            
            monthlyExistence = true
            self.lblMonthlyTitle.text = title
            self.tvMContent.text = content
            self.tvMContent.textColor = UIColor.black // textview 글자색
        }else{
//            print("no db Data")
            monthlyExistence = false
            self.lblMonthlyTitle.text = "#Monthly"
            self.tvMContent.text = "+ 버튼을 눌러보세요!"
            self.tvMContent.textColor = UIColor(named: "AccentColor") // textview 글자색
        }
        
        sqlite3_finalize(stmt)

    }
    
    // MARK: 아이폰 모델에 따라 Collection View 사이즈 조정 Function
    private func deviceWidth() -> CGFloat {
        let deviceName = UIDevice.current.name
        var width : CGFloat
        
        switch deviceName {
        case "iPhone 3gs","iPhone 4","iPhone 4s","iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320
            width = 320
        case "iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone 12 mini","iPhone 13 mini","iPhone SE (2nd generation)", "iPhone SE (3rd generation)", "iPhone X","iPhone Xs","iPhone 11 Pro" : // 375
            width = 375 
        case "iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14": // 390
            width = 390
        case "iPhone 14 Pro": // 393
            width = 393
        case "iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus","iPhone Xʀ","iPhone 11","iPhone Xs Max","iPhone 11 Pro Max": // 414
            width = 414
        case "iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus": // 428
            width = 428
        case "iPhone 14 Pro Max" : // 430
            width = 430
        default : //
            width = 380
        }
        return width
    }// Func deviceWidth
    
    // MARK: segue MonthlyView로 값 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let monthlyPopUpViewController = segue.destination as? MonthlyPopUpViewController
        if segue.identifier == "sgMonthly"{
            let date = lblDateTitle.text?.components(separatedBy: " ")
            monthlyPopUpViewController?.year = date![0]
            monthlyPopUpViewController?.month = date![1]
            monthlyPopUpViewController?.mvTitle = lblMonthlyTitle.text!
            monthlyPopUpViewController?.mvContent = tvMContent.text == "+ 버튼을 눌러보세요!" ? "" : tvMContent.text
            monthlyPopUpViewController?.existence = monthlyExistence // DB select 존재 여부
            monthlyPopUpViewController?.monthlyID = monthlyBundle.isEmpty ? 0 : monthlyBundle[0].id
        }
    }// prepare

    // MARK: DISMISS 후 화면 재로딩
    @objc
    private func didDismissMonthlyNotification(_ notification:Notification) {
         readMonthlyValues()
        if monthlyExistence == true{
            lblMonthlyTitle.text = monthlyBundle[0].title
            tvMContent.text = monthlyBundle[0].content
        }

    }//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //MainViewController

// MARK:  Collection View 구성 Extension
/* Collection View Cell */
extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    // Cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allDateItems.count
    }
    // Cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarCell
        // Date
        cell.lblDay.text = allDateItems[indexPath.row]
        // Font Color
        switch indexPath.row {
        case 0..<items.startWeekDay:
            cell.lblDay.textColor = .lightGray
            cell.isUserInteractionEnabled = false // cell 선택 비활성화
        case (items.daysInMonth + items.startWeekDay)..<allDateItems.count:
            cell.lblDay.textColor = .lightGray
            cell.isUserInteractionEnabled = false
        default:
            cell.lblDay.textColor = .darkGray
            cell.isUserInteractionEnabled = true
        }
        // Today 표시
        if cell.lblDay.text == CalendarBuilder().dayString(date: todayDate) &&  CalendarBuilder().monthString(date: todayDate) == CalendarBuilder().monthString(date: presentDate) && cell.lblDay.textColor == .darkGray{
            cell.lblToday.isHidden = false
        }

        return cell
    }

}// Delegate, DataSouce

extension MainViewController:UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 7 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
    //
    
}// DelegateFlowLayout
