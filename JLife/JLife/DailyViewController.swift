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
    @IBOutlet weak var cvTodo: UICollectionView!
    @IBOutlet weak var lblNotice: UILabel!
    @IBOutlet weak var lblTodayScore: UILabel!
    
    // MARK: 변수선언
    var mvYear = 0
    var mvMonth = 0
    var mvDay = 0
    var dailyExistence = false
    let dailyNotice = "Today's Box가 비어있어요!"
    
    // MARK: DB 변수선언
    var todoID = 0
    var db : OpaquePointer?
    let dbDateFormat = DateFormatter()
    var dbDate = ""
    var dailyBundle:[Daily] = []
    var todoData:[Todo] = []
       
    override func viewDidLoad() {
        super.viewDidLoad()
        cvTodo.dataSource = self
        cvTodo.delegate = self
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
            try await readTodoValues()
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
    // MARK: 할일완료 check버튼
    @IBAction func checkBtn(_ sender: UIButton) {
        let alertVC = AlertViewController()
        let cell = (sender.superview?.superview as? UICollectionViewCell)
        let indexPath = self.cvTodo.indexPath(for: cell!)
        let font = UIFont(name: "Cafe24Ssurroundair", size: 16)
//        print(todoData[indexPath!.row].content!)
        
        let titleText: String = "할 일을 완료하셨나요? \n성취도(몰입도)를 평가해 주세요!"
        let attributeText = NSMutableAttributedString(string: titleText)
        attributeText.addAttribute(.font, value: font!, range: (titleText as NSString).range(of: "\(titleText)"))
        let alert = UIAlertController(title: titleText, message: "", preferredStyle: .alert)
        alert.setValue(alertVC, forKey: "contentViewController")
        alert.setValue(attributeText, forKey: "attributedTitle")
        
        let cancelAction = UIAlertAction(title: "아직 안했어요", style: .default)
        let okAction = UIAlertAction(title: "완료!", style: .destructive){ _ in
//            print("슬라이드 값 : \(alertVC.sliderValue)")
            self.updateScoreActionT(self.todoData[indexPath!.row].id, alertVC.sliderValue, 1)
            Task{
                try await self.readTodoValues()
            }
        }
        
        cancelAction.setValue(UIColor(named: "GrayColor"), forKey: "titleTextColor")
        okAction.setValue(UIColor(named: "AccentColor"), forKey: "titleTextColor")
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
    
    // MARK: segue 값 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dailyPopUpViewController = segue.destination as? DailyPopUpViewController
        let todoViewController = segue.destination as? DayTodoViewController
        if segue.identifier == "sgDaily"{
            dailyPopUpViewController?.dvDate = dbDate
            dailyPopUpViewController?.dvContent = tvDaily.text == dailyNotice ? "" : tvDaily.text
            dailyPopUpViewController?.tvExistence = dailyExistence
            dailyPopUpViewController?.dailyID = dailyBundle.isEmpty ? 0 : dailyBundle[0].id
        }else if segue.identifier == "sgTodo"{
            todoViewController?.sgKind = "insert"
            todoViewController?.existTodoData[0].date = "\(mvYear)\(mvMonth)\(mvDay)"
            
        }else if segue.identifier == "sgTodoCell"{ // time,content
            let cell = sender as! UICollectionViewCell
            let indexPath = self.cvTodo.indexPath(for: cell)
            
            todoViewController?.sgKind = "update"
            todoViewController?.existTodoData[0] = todoData[indexPath!.row]
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
            try await readTodoValues()
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
    // MARK: sql create todolist
    private func createTodoTable() async throws{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening Todo database")
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todo (tid INTEGER PRIMARY KEY AUTOINCREMENT, tdate TEXT, ttime TEXT, tcontent TEXT, tcomplete INTEGER , tscore REAL)", nil, nil, nil) != SQLITE_OK{
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
            self.tvDaily.textColor = UIColor(named: "TextColor") // textview 글자색
        }else{
//            print("no db Data")
            dailyExistence = false
            self.tvDaily.text = dailyNotice
            self.tvDaily.textColor = UIColor(named: "PinkColor") // textview 글자색
        }
        sqlite3_finalize(stmt)
    }//
    // MARK: sql todolist select
    private func readTodoValues() async throws {
        try await createTodoTable()
        todoData.removeAll()
        defer{
            sqlite3_close(db)
        }
        let queryString = "SELECT tid, ttime, tcontent, tcomplete, tscore FROM todo WHERE tdate = ? ORDER BY tcomplete, (CASE WHEN ttime LIKE '오전__시%' THEN 1  WHEN ttime LIKE '오전___시%' THEN 2 WHEN ttime LIKE '오후__시%' THEN 3 WHEN ttime LIKE '오후___시%' THEN 4 ELSE 5 END) "
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let date = "\(mvYear)\(mvMonth)\(mvDay)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing t select : \(errmsg)")
            return
        }
        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            // DB 있는 경우
            let id = sqlite3_column_int(stmt, 0)
            let time = String(cString: sqlite3_column_text(stmt, 1))
            let content = String(cString: sqlite3_column_text(stmt, 2))
            let completion = sqlite3_column_int(stmt, 3)
            let score = sqlite3_column_double(stmt, 4)
//            print(id,date,time,content,completion,score)
            todoData.append(Todo(id: Int(id), time: time, content: content, complete: Int(completion) ,score: Float(score) ))
        }
        if todoData.count != 0 {
            self.lblNotice.isHidden =  true
        }else{
            self.lblNotice.isHidden = false
        }
        // lblScore에 값 넣기
        
        self.cvTodo.reloadData()
        sqlite3_finalize(stmt)
    }//
    
    // MARK: SQLite - update Score
    private func updateScoreActionT(_ tid : Int, _ tscore : Float, _ tcompletion : Int ) {
        defer{
            sqlite3_close(db)
        }
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening Todo database")
        }
        var stmt:OpaquePointer?
        let queryString = "UPDATE todo SET tscore = ?, tcomplete = ? WHERE tid = ?"
        // 사용자 입력 값
        let id = Int32(tid)
        let score = Double(tscore)
        let complete = Int32(tcompletion)
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing update score : \(errmsg)")
            return
        }
        // ?에 데이터 매칭
        sqlite3_bind_double(stmt, 1, score)
        sqlite3_bind_int(stmt, 2, complete)
        sqlite3_bind_int(stmt, 3, id)
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure score updating : \(errmsg)")
            return
        }
        sqlite3_finalize(stmt)
    }// update
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}// DailyViewController
// MARK: Collection View Extension
extension DailyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    // cell 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        todoData.count
    }
    // cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todoCell", for: indexPath) as! TodoListCell
        // time, content
        if todoData[indexPath.row].time == "선택 안함"{
            cell.lblTime.text = ""
        }else{
            cell.lblTime.text = todoData[indexPath.row].time
        }
        cell.lblContent.text = todoData[indexPath.row].content
        // 완료
        if todoData[indexPath.row].complete == 0 {
            cell.checkBtnOut.setImage(UIImage(systemName: "square"), for: .normal)
            cell.lblTime.textColor = UIColor(named: "TextColor")
            cell.lblContent.textColor = UIColor(named: "TextColor")
        }else{
            cell.checkBtnOut.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            cell.lblTime.textColor = UIColor(named: "GrayColor")
            cell.lblContent.textColor = UIColor(named: "GrayColor")
        }
        return cell
    }
    
}// Delegate, Datasource
extension DailyViewController:UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = CGFloat(60)
        let size = CGSize(width: width, height: height)
        return size
    }
}// DelegateFlowLayout
