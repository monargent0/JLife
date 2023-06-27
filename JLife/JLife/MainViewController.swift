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
    @IBOutlet weak var svWeek: UIStackView! // 상단 요일
    
    // MARK: 변수 선언
    var presentDate = Date() // 현재
    var allDateItems : [String] = [] //
    var items : (daysInMonth : Int , startWeekDay : Int) = (0,0) //
    
    // MARK: Monthly SQLite
    var monthlyBundle:[Monthly] = []
    var db: OpaquePointer? // DB포인터
    
    // Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        cvCalendar.dataSource = self
        cvCalendar.delegate = self
        // 달력 구성
        setMonth(presentDate)
        // SQL 구성
        createTable()
        // Collection View Size
        cvCalendar.translatesAutoresizingMaskIntoConstraints = false // 스토리보드에서 적용한것 무시
        cvCalendar.widthAnchor.constraint(equalToConstant: deviceWidth()).isActive = true // 가로
        cvCalendar.heightAnchor.constraint(equalToConstant: ceil((deviceWidth()/7)*6) ).isActive = true // 세로
        cvCalendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // 가로 중앙 정렬
        cvCalendar.topAnchor.constraint(equalTo:svWeek.bottomAnchor,constant: 10).isActive = true // 세로 위치
        
        
    }
    // Will Appear
    override func viewWillAppear(_ animated: Bool) {
        //
    }
    
    // MARK: 버튼 연결
    @IBAction func btnPrevMonth(_ sender: UIButton) {
        presentDate = CalendarBuilder().minusMonth(date: presentDate)
        setMonth(presentDate)
    }
    
    @IBAction func btnNextMonth(_ sender: UIButton) {
        presentDate = CalendarBuilder().plusMonth(date: presentDate)
        setMonth(presentDate)
    }
    
//    @IBAction func btnMonthly(_ sender: UIButton) {
//        let addAlert = UIAlertController(title: "Month 화면 수정", message: "좋아하는 노래 가사나 이번달 나의 다짐을 적어보세요!", preferredStyle: .alert)
//        addAlert.addTextField{ ACTION in
//            ACTION.placeholder = "수많은 별이 그랬듯이 언제나 같은 자리 제 몫의 빛으로 환하게 비출 테니"
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        let okAction = UIAlertAction(title: "추가", style: .default, handler: nil)
//        addAlert.addAction(cancelAction)
//        addAlert.addAction(okAction)
//        present(addAlert, animated: true)
//    }//
    
    
    // MARK: Setting Calendar Function
    func setMonth(_ date:Date){
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
    func createTable(){
        // Monthly
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "MonthlyData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS monthly (mid INTEGER PRIMARY KEY AUTOINCREMENT, myear TEXT, mmonth TEXT, mtitle TEXT, mcontent TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating table \(errmsg)")
            return
        }//Monthly
    }
    
    
    // MARK: 아이폰 모델에 따라 Collection View 사이즈 조정 Function
    func deviceWidth() -> CGFloat {
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
        default : // iPhone 14 Pro Max
            width = 430
        }
        return width
    }// Func deviceWidth
    
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
        case (items.daysInMonth + items.startWeekDay)..<allDateItems.count:
            cell.lblDay.textColor = .lightGray
        default:
            cell.lblDay.textColor = .darkGray
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
