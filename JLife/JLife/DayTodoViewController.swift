//
//  DayTodoViewController.swift
//  JLife
//
//  Created by OoO on 2023/07/03.
//

import UIKit
//import SQLite3

final class DayTodoViewController: UIViewController {
    
//
//    // MARK: 스토리보드 연결
//    @IBOutlet weak var tvTodo: UITextView!
//    @IBOutlet weak var addButton: UIButton!
//    @IBOutlet weak var lblTvCount: UILabel!
//    @IBOutlet weak var lblSelectTime: UILabel!
//    @IBOutlet weak var picker: UIDatePicker!
//    @IBOutlet weak var timeSwitch: UISwitch!
//    @IBOutlet weak var deleteButton: UIButton!
//    
//    // MARK: 변수 선언
//    var tvMaxLength = 50
//    let DidDismissTodoAddViewController:Notification.Name = Notification.Name("DidDismissTodoAddViewController")
//    
//    // Dailyview에서 넘어오는 값
//    var sgKind = "insert"
//    var existTodoData:[Todo] = [Todo(id: 0, date: "", time: "선택 안함", content: "", complete: 0, score: 0.0)]
//    // SQLITE
//    var db : OpaquePointer?
//    var firstTimeTxt = ""
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tvMaxLength = deviceTvCount()
//        // 화면 setting
//        addButton.isEnabled = false
//        if sgKind == "insert"{
//            tvTodo.becomeFirstResponder()
//            deleteButton.isHidden = true
//            addButton.setTitle("추가", for: .normal)
//        }else{
//            deleteButton.isHidden = false
//            addButton.setTitle("수정", for: .normal)
//        }
//        tvTodo.text = existTodoData[0].content
//        lblTvCount.text = "\(tvTodo.text.count) / \(tvMaxLength)"
//        lblSelectTime.text = "시간 : \(existTodoData[0].time!)"
//        let firstTime = existTodoData[0].time == "선택 안함" ? false : true
//        timeSwitch.isOn = firstTime
//        timeSelec(firstTime)
//        firstTimeTxt = existTodoData[0].time!
//        //delegate
//        tvTodo.delegate = self
//        // 레이아웃
//        tvTodo.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
//        tvTodo.layer.borderWidth = 0.7
//        tvTodo.layer.cornerRadius = 5
//        // SQLite
//        if #available(iOS 16.0, *) {
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoData.sqlite")
//            if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }else{
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("TodoData.sqlite")
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }
//        view.snapshotView(afterScreenUpdates: true)
//    }
//    // MARK: 버튼
//    // switch
//    @IBAction func timeSwitchAction(_ sender: UISwitch) {
//        timeSelec(timeSwitch.isOn)
//        if sgKind == "update" {
//            if firstTimeTxt != existTodoData[0].time{
//                addButton.isEnabled = true
//            }else{
//                addButton.isEnabled = false
//            }
//        }
//    }
//    // 취소
//    @IBAction func btnCancel(_ sender: UIButton) {
//        NotificationCenter.default.post(name: DidDismissTodoAddViewController, object: nil)
//        dismiss(animated: true)
//    }
//    // 추가
//    @IBAction func btnAdd(_ sender: UIButton) {
//        if sgKind == "insert"{
//            insertActionT(tvTodo.text, existTodoData)
//        }else if sgKind == "update"{
//            updateActionT(tvTodo.text, existTodoData)
//        }
//        NotificationCenter.default.post(name: DidDismissTodoAddViewController, object: nil)
//        dismiss(animated: true)
//    }
//    
//    @IBAction func btnDelete(_ sender: UIButton) {
//        deleteActionT(existTodoData[0].id)
//        NotificationCenter.default.post(name: DidDismissTodoAddViewController, object: nil)
//        dismiss(animated: true)
//    }
//    
//    // MARK: TimePicker
//    @IBAction func timePicker(_ sender: UIDatePicker) {
//        let senderTP = sender
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_kr") // 해외출시할때 고민
//        formatter.dateFormat = "a h시 mm분"
//        let time = formatter.string(from: senderTP.date)
//        existTodoData[0].time = time
//        lblSelectTime.text = "시간: \(time)" //수정
//        if sgKind == "update" {
//            if firstTimeTxt != existTodoData[0].time{
//                addButton.isEnabled = true
//            }
//        }
//    }
//    
//    private func timeSelec(_ switchState : Bool) {
//        if switchState == false {
//            picker.isHidden = true
//            existTodoData[0].time = "선택 안함"
//            lblSelectTime.text = "시간: \(existTodoData[0].time!)"
//        }else {
//            picker.isHidden = false
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier: "ko_kr")// 해외출시할때,,
//            formatter.dateFormat = "a h시 mm분"
//            if sgKind == "update" && existTodoData[0].time != "선택 안함" {
//                picker.date = formatter.date(from: existTodoData[0].time!)!
//            }else{
//                existTodoData[0].time = formatter.string(from: picker.date)
//            }
//            lblSelectTime.text = "시간: \(existTodoData[0].time!)"
//        }
//    }// timeSelec
//    
//    // MARK: SQLite
//    // MARK: SQLite - insert
//    private func insertActionT(_ tvContent:String,_ todoData : [Todo] ) {
//        defer{
//            sqlite3_close(db)
//        }
//        var stmt:OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let queryString = "INSERT INTO todo (tdate, ttime, tcontent, tcomplete, tscore) VALUES (?,?,?,?,?)"
//        // 사용자 입력 값
//        let date = todoData[0].date!
//        let time = todoData[0].time!
//        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        let complete = Int32(todoData[0].complete!)
//        let score = Int32(todoData[0].score!)
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing insert : \(errmsg)")
//            return
//        }
//        // ?에 데이터 매칭
//        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, time, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 3, content, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_int(stmt, 4, complete)
//        sqlite3_bind_int(stmt, 5, score)
//        
//        if sqlite3_step(stmt) != SQLITE_DONE{
////            let errmsg = String(cString: sqlite3_errmsg(db)!)
////            print("failure inserting : \(errmsg)")
//            return
//        }
//        sqlite3_finalize(stmt)
//    }// insert
//    
//    // MARK: SQLite - update
//    private func updateActionT(_ tvContent:String, _ todoData : [Todo] ) {
//        defer{
//            sqlite3_close(db)
//        }
//        var stmt:OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let queryString = "UPDATE todo SET ttime = ?, tcontent = ? WHERE tid = ?"
//        // 사용자 입력 값
//        let id = Int32(todoData[0].id)
//        let time = todoData[0].time!
//        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing update : \(errmsg)")
//            return
//        }
//        // ?에 데이터 매칭
//        sqlite3_bind_text(stmt, 1, time, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_int(stmt, 3, id)
//        
//        if sqlite3_step(stmt) != SQLITE_DONE{
////            let errmsg = String(cString: sqlite3_errmsg(db)!)
////            print("failure updating : \(errmsg)")
//            return
//        }
//        sqlite3_finalize(stmt)
//    }// update
//    
//    // MARK: SQLite - update
//    private func deleteActionT(_ id: Int ) {
//        defer{
//            sqlite3_close(db)
//        }
//        var stmt:OpaquePointer?
//        let queryString = "DELETE FROM todo WHERE tid = ?"
//        // 사용자 입력 값
//        let id = Int32(id)
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing update : \(errmsg)")
//            return
//        }
//        // ?에 데이터 매칭
//        sqlite3_bind_int(stmt, 1, id)
//        
//        if sqlite3_step(stmt) != SQLITE_DONE{
////            let errmsg = String(cString: sqlite3_errmsg(db)!)
////            print("failure deleting : \(errmsg)")
//            return
//        }
//        sqlite3_finalize(stmt)
//    }// delete
//    
//    // MARK: 아이폰 모델에 따라 Max 글자수 조정 Function
//    private func deviceTvCount() -> Int {
//        let screenWidth = UIScreen.main.bounds.size.width
//        var length : Int
//        
//        switch screenWidth {
//        case 320: // "iPhone 3gs","iPhone 4","iPhone 4s","iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320
//            length = 42
//        case 375: //"iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone 12 mini","iPhone 13 mini","iPhone SE (2nd generation)", "iPhone SE (3rd generation)", "iPhone X","iPhone Xs","iPhone 11 Pro" : // 375
//            length = 48
//        case 390, 393: //"iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14","iPhone 14 Pro": // 390 , 393
//            length = 54
//        case 414: //"iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus","iPhone Xʀ","iPhone 11","iPhone Xs Max","iPhone 11 Pro Max": // 414
//            length = 58
//        case 428, 430: //"iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus","iPhone 14 Pro Max": // 428 ,430
//            length = 62
//        default : //
//            length = Int(round(screenWidth * 0.14))
//        }
//        return length        
//    }// Func deviceTvCount
//    
//    // MARK: 아무곳이나 눌러 softkeyboard 지우기
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
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
//}//DayTodoViewController
//// MARK: extension TV
//extension DayTodoViewController:UITextViewDelegate{
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let tvCount = tvTodo.text!.count
//        // 백스페이스
//        if let char = text.cString(using: String.Encoding.utf8){
//            let isBackSpace = strcmp(char, "\\b")
//            if isBackSpace == -92 {
//                return true
//            }
//        }//
//        if tvCount == self.tvMaxLength ||  text == "\n"{
//            tvTodo.resignFirstResponder()
//        }
//        return true
//    }// textview shouldchange
//    func textViewDidChange(_ textView: UITextView) {
//        switch textView {
//           case tvTodo:
//               if let text = tvTodo.text{
//                   if text.count > tvMaxLength {
//                       let maxIndex = text.index(text.startIndex, offsetBy: tvMaxLength)
//                       let newString = String(text[text.startIndex..<maxIndex])
//                       tvTodo.text = newString
//                       //print(newString)//@지워
//                   }
//               }
//           default: return
//           }//
//        // button 활성화
//        if tvTodo.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
//            addButton.isEnabled = false
//        }else {
//            addButton.isEnabled = true
//        }
//        // 글자수 라벨 실시간
//        let count = String(tvTodo.text!.count)
//        lblTvCount.text = "\(count) / \(tvMaxLength)"
//    }// textview didchange
}
