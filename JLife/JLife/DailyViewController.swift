//
//  DailyViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit
import SQLite3

class DailyViewController: UIViewController , UITextViewDelegate {
    // MARK: 스토리보드 연결
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tvDaily: UITextView!

    // MARK: 변수선언
    var mvYear = 0
    var mvMonth = 0
    var mvDay = 0
    var dailyExistence = false
    
    // MARK: DB 변수선언
    var todoID = 0
    var db : OpaquePointer?
    let dbDateFormat = DateFormatter()
    var dbDate = ""
    var dailyBundle:[Daily] = []
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Date label
        let dateComponent = DateComponents(year:mvYear, month: mvMonth, day: mvDay)
        let date = Calendar.current.date(from: dateComponent)
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_kr")
        dateFormat.dateFormat = "M월 d일 EEEE"
        lblDate.text = dateFormat.string(from: date!)
        // DB 입력용 날짜
        dbDateFormat.dateStyle = .long
        dbDate = dateFormat.string(from: date!)
        // DailyText Border
        tvDaily.layer.borderColor = UIColor.lightGray.cgColor
        tvDaily.layer.borderWidth = 1.0
        tvDaily.layer.cornerRadius = 5
        // SQL Func
        Task{
            try await readDailyValues()
//            try await readTodoValues()
        }
        // modal dismiss notification
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissDailyNotification(_ :)), name: Notification.Name("DidDismissDailyViewController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissTodoAddNotification(_ :)), name: Notification.Name("DidDismissTodoAddViewController"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if dailyExistence == true{
            tvDaily.text = dailyBundle[0].content
        }
        
    }
    
    // MARK: segue DailyPopUpView로 값 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dailyPopUpViewController = segue.destination as? DailyPopUpViewController
        if segue.identifier == "sgDaily"{
            dailyPopUpViewController?.dvDate = dbDate
            dailyPopUpViewController?.dvContent = tvDaily.text == "+ 버튼을 눌러보세요!" ? "" : tvDaily.text
            dailyPopUpViewController?.tvExistence = dailyExistence
            dailyPopUpViewController?.dailyID = dailyBundle.isEmpty ? 0 : dailyBundle[0].id
        }
    }// prepare
    
    // MARK: DISMISS 후 화면 재로딩
    @objc
    private func didDismissDailyNotification(_ notification:Notification) {
        Task{
            try await readDailyValues()
        }
        if dailyExistence == true{
            tvDaily.text = dailyBundle[0].content
        }
    }//Daily
    @objc
    private func didDismissTodoAddNotification(_ notification:Notification) {
        Task{
//            try await readTodoValues()
        }
    }//TodoAdd
    
    // MARK: SQLITE --
    // MARK: sql create daily
    private func createDailyTable() async throws{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "DailyData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening daily database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS daily (did INTEGER PRIMARY KEY AUTOINCREMENT, ddate TEXT, dcontent TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating daily table \(errmsg)")
            return
        }else{
//            print("create daily ok")
        }
    }
    // MARK: sql create todolist - main에서 만드나?
    private func createTodoTable() async throws{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoyData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening Todo database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todo (tid INTEGER PRIMARY KEY AUTOINCREMENT, tdate TEXT, tcontent TEXT, tcomplete INTEGER , tscore INTEGER)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error creating todo table \(errmsg)")
            return
        }else{
//            print("create todo ok")
        }
    }
    // MARK: sql daily select
    private func readDailyValues() async throws{
        try await createDailyTable()
        dailyBundle.removeAll()
        defer{
            sqlite3_close(db)
        }
        let queryString = "SELECT did, dcontent FROM daily WHERE ddate = ?"
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let date = dbDate
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing d select : \(errmsg)")
            return
        }
        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
        
//        print("sqlite row ",SQLITE_ROW)
        if sqlite3_step(stmt) == SQLITE_ROW{
            // DB 있는 경우
            let id = sqlite3_column_int(stmt, 0)
            let content = String(cString: sqlite3_column_text(stmt, 1))
//            print(id, content)
            dailyBundle.append(Daily(id: Int(id) ,content: content))
            
            dailyExistence = true
            self.tvDaily.text = content
            self.tvDaily.textColor = UIColor.black // textview 글자색
        }else{
//            print("no db Data")
            dailyExistence = false
            self.tvDaily.text = "+ 버튼을 눌러보세요!"
            self.tvDaily.textColor = UIColor(named: "AccentColor") // textview 글자색
        }
        
        sqlite3_finalize(stmt)

    }
    // MARK: sql todolist select
    private func readTodoValues() async throws {
        try await createTodoTable()
        // todoList.removeAll()
        defer{
            sqlite3_close(db)
        }
        let queryString = "SELECT tid, tcontent, tcomplete, tscore FROM todo WHERE tdate = ?"
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let date = dbDate
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing t select : \(errmsg)")
            return
        }
        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) == SQLITE_ROW{
            // DB 있는 경우
            let id = sqlite3_column_int(stmt, 0)
            let content = String(cString: sqlite3_column_text(stmt, 1))
            let completion = sqlite3_column_int(stmt, 2)
            let score = sqlite3_column_int(stmt, 3)
            print(id,content,completion,score)
            // 이거로 collection view 만들어야함
        }else{
//            print("no db Data")
            // collectionview 빈공간
     
        }
        
        sqlite3_finalize(stmt)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
