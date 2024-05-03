//
//  DailyPopUpViewController.swift
//  JLife
//
//  Created by OoO on 2023/07/02.
//

import UIKit
import SQLite3

class DailyPopUpViewController: UIViewController {
//
//    // MARK: 스토리보드 연결
//    @IBOutlet weak var tvDContent: UITextView!
//    @IBOutlet weak var enterButton: UIButton!
//    @IBOutlet weak var lblTvCount: UILabel!
//    
//    // MARK: 변수 선언
//    var tvMaxLength = 150
//    let DidDismissDailyViewController:Notification.Name = Notification.Name("DidDismissDailyViewController")
//    
//    // MARK: DB관련 변수
//    var db : OpaquePointer?
//    var tvExistence = false //*
//    var dvContent : String = "" //*
//    var dailyID = 0 //*
//    var dvDate = "" //*
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // DailyView에서 넘어오는 값
//        tvDContent.text = dvContent
//        if dvContent.isEmpty {
//            tvExistence = false
//        }else{
//            tvExistence = true
//        }
//        // 기종별 textview길이 변동 적용 function
////        tvMaxLength = deviceTvCount()
//        // 글자 갯수 카운팅 라벨
//        lblTvCount.text = "\(String(tvDContent.text!.count)) / \(tvMaxLength)"
//        // 버튼 비활성화
//        enterButton.isEnabled = false
//        // SQLite
//        if #available(iOS 16.0, *) {
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "DailyData.sqlite")
//            if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }else{
//            let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DailyData.sqlite")
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
////                print("error opening monthly database")
//            }
//        }
//        
//        // Delegate
//        tvDContent.delegate = self
//        // 레이아웃
//        tvDContent.layer.borderColor = UIColor(named: "PinkColor")?.cgColor
//        tvDContent.layer.borderWidth = 0.7
//        tvDContent.layer.cornerRadius = 5
//        // 화면 half 사이즈 지정
//        if let sheet = sheetPresentationController {
//            sheet.detents = [.medium()]
//        }
//    }//viewDidLoad
//    
//    // MARK: 버튼
//    // 취소
//    @IBAction func btnCancel(_ sender: UIButton) {
//        NotificationCenter.default.post(name: DidDismissDailyViewController, object: nil)
//        dismiss(animated: true)
//    }
//    // 확인 (insert / update)
//    @IBAction func btnEnter(_ sender: UIButton) {
//        if tvExistence == false{
//            // insert
//            insertActionD(dvDate, tvDContent.text!)
//        }else if tvExistence == true{
//            // update
//            updateActionD(dailyID, tvDContent.text!)
//        }
//        NotificationCenter.default.post(name: DidDismissDailyViewController, object: nil)
//        dismiss(animated: true)
//    }
//    // MARK: SQLite
//    // MARK: SQLite - insert
//    private func insertActionD(_ dvdate : String ,_ tvContent:String) {
//        defer{
//            sqlite3_close(db)
//        }
//        var stmt:OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let queryString = "INSERT INTO daily (ddate,dcontent) VALUES (?,?)"
//        // 사용자 입력 값
//        let date = dvdate
//        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing insert : \(errmsg)")
//            return
//        }
//        // ?에 데이터 매칭
//        sqlite3_bind_text(stmt, 1, date, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
//        
//        if sqlite3_step(stmt) != SQLITE_DONE{
////            let errmsg = String(cString: sqlite3_errmsg(db)!)
////            print("failure inserting : \(errmsg)")
//            return
//        }
//        sqlite3_finalize(stmt)
//    }// insert
//    // MARK: SQLite - update
//    private func updateActionD(_ dailyid : Int ,_ tvContent:String) {
//        defer{
//            sqlite3_close(db)
//        }
//        var stmt:OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
//        let queryString = "UPDATE daily SET dcontent = ? WHERE did = ?"
//        // 사용자 입력 값
//        let id = Int32(dailyid)
//        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
////            let errmsg = String(cString: sqlite3_errmsg(db))
////            print("error preparing update : \(errmsg)")
//            return
//        }
//        // ?에 데이터 매칭
//        sqlite3_bind_text(stmt, 1, content, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_int(stmt, 2, id)
//        
//        if sqlite3_step(stmt) != SQLITE_DONE{
////            let errmsg = String(cString: sqlite3_errmsg(db)!)
////            print("failure updating : \(errmsg)")
//            return
//        }
//        sqlite3_finalize(stmt)
//
//    }//update
//    
//    // MARK: 아이폰 모델에 따라 Max 글자수 조정 Function
////    private func deviceTvCount() -> Int {
////        let deviceName = UIDevice.current.name
////        var length : Int
////
////        switch deviceName {
////        case "iPhone 3gs","iPhone 4","iPhone 4s","iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320
////            length = 55
////        case "iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone 12 mini","iPhone 13 mini","iPhone SE (2nd generation)", "iPhone SE (3rd generation)", "iPhone X","iPhone Xs","iPhone 11 Pro" : // 375
////            length = 60
////        case "iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14": // 390
////            length = 64
////        case "iPhone 14 Pro": // 393
////            length = 64
////        case "iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus","iPhone Xʀ","iPhone 11","iPhone Xs Max","iPhone 11 Pro Max": // 414
////            length = 72
////        case "iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus": // 428
////            length = 76
////        case "iPhone 14 Pro Max" : // 430
////            length = 76
////        default : //
////            length = 60
////        }
////        return length
////    }// Func deviceTvCount
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
//}//DailyPopUpViewController
//// MARK: extension TV 글자수 제한
//extension DailyPopUpViewController:UITextViewDelegate{
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let tvCount = tvDContent.text!.count
//        // 백스페이스
//        if let char = text.cString(using: String.Encoding.utf8){
//            let isBackSpace = strcmp(char, "\\b")
//            if isBackSpace == -92 {
//                return true
//            }
//        }//
//        if tvCount == self.tvMaxLength{
//            tvDContent.resignFirstResponder()
//        }
//        return true
//    }// textview shouldchange
//    
//    func textViewDidChange(_ textView: UITextView) {
//        switch textView {
//           case tvDContent:
//               if let text = tvDContent.text{
//                   if text.count > tvMaxLength {
//                       let maxIndex = text.index(text.startIndex, offsetBy: tvMaxLength)
//                       let newString = String(text[text.startIndex..<maxIndex])
//                       tvDContent.text = newString
//                       //print(newString)//@지워
//                   }
//               }
//           default: return
//           }//
//        // button 활성화
//        if tvDContent.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
//            enterButton.isEnabled = false
//        }else {
//            enterButton.isEnabled = true
//        }
//        // 글자수 라벨 실시간
//        let count = String(tvDContent.text!.count)
//        lblTvCount.text = "\(count) / \(tvMaxLength)"
//    }// textviewdidchange
}//UITextViewDelegate
