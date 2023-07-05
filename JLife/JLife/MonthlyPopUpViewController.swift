//
//  MonthlyPopUpViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/27.
//

import UIKit
import SQLite3 /**/

class MonthlyPopUpViewController: UIViewController {
    // MARK: 스토리보드 연결
    @IBOutlet weak var tfMTitle: UITextField!
    @IBOutlet weak var tvMContent: UITextView!
    @IBOutlet weak var EnterButton: UIButton!
    @IBOutlet weak var lblTfCount: UILabel!
    @IBOutlet weak var lblTvCount: UILabel!
    
    // MARK: 변수 선언
    let tfMaxLength = 20
    var tvMaxLength = 0
    var monthlyID = 0
    let DidDismissMonthlyViewController:Notification.Name = Notification.Name("DidDismissMonthlyViewController")
    
    // MARK: DB 관련 변수
    var year : String = ""
    var month : String = ""
    var mvTitle : String = ""
    var mvContent : String = ""
    var existence = false // data 존재 여부
    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* mainview에서 넘어오는 값 */
//        print("\(year) , \(month), \(existence) , \(monthlyID)")
        tfMTitle.text = mvTitle
        tvMContent.text = mvContent
        if mvTitle == "#Monthly" && mvContent.isEmpty {
            existence = false
        }else{
            existence = true
        }
        // 기종별 textview길이 변동 적용 function
        tvMaxLength = deviceTvCount()
        // 글자 갯수 카운팅 라벨
        lblTfCount.text = "\(String(tfMTitle.text!.count)) / \(tfMaxLength)"
        lblTvCount.text = "\(tvMContent.text.count) / \(tvMaxLength)"
        // 초기 수정 버튼 비활성화
        EnterButton.isEnabled = false
        
        // SQLITE
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "MonthlyData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening monthly database")
        }
        
        // 인식 NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        // Delegate 연결
        tfMTitle.delegate = self
        tvMContent.delegate = self

        // DailyText Border 레이아웃
        tfMTitle.layer.borderWidth = 0.7
        tfMTitle.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tfMTitle.layer.cornerRadius = 5
        tvMContent.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tvMContent.layer.borderWidth = 0.7
        tvMContent.layer.cornerRadius = 5
        // 화면 half 사이즈
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
        }
    }
    
    // MARK: 버튼
    // 취소
    @IBAction func btnBack(_ sender: UIButton) {
        NotificationCenter.default.post(name: DidDismissMonthlyViewController, object: nil)
        dismiss(animated: true)
    }
    // 수정
    // select(main에서 해서 segue로 보내기) 해서 없으면 insert 있으면 update 쿼리를 사용해야함
    @IBAction func btnEnter(_ sender: UIButton) {
        if existence == false{
            // insert
            insertActionM(year, month, tfMTitle.text!, tvMContent.text!)
            
        }else if existence == true{
            // update
            updateActionM(monthlyID, tfMTitle.text!, tvMContent.text!)
        }
        NotificationCenter.default.post(name: DidDismissMonthlyViewController, object: nil)
        dismiss(animated: true)
    }
    /* ----- */
    
    // MARK: SQLITE
    func insertActionM(_ year : String , _ month : String ,_ tfTitle:String ,_ tvContent:String) {
        var stmt:OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let queryString = "INSERT INTO monthly (myear,mmonth,mtitle,mcontent) VALUES (?,?,?,?)"
        // 사용자 입력 값
        let myear = year
        let mmonth = month
        let title = tfTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing insert : \(errmsg)")
            return
        }
        // ?에 데이터 매칭
        sqlite3_bind_text(stmt, 1, myear, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, mmonth, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 3, title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 4, content, -1, SQLITE_TRANSIENT)
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting : \(errmsg)")
            return
        }
        sqlite3_finalize(stmt)
    }// insert
    
    func updateActionM(_ mid : Int ,_ tfTitle:String ,_ tvContent:String) {
        var stmt:OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self) // 한글
        let queryString = "UPDATE monthly SET mtitle = ?, mcontent = ? WHERE mid = ?"
        // 사용자 입력 값
        let id = Int32(mid)
        let title = tfTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let content = tvContent.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing insert : \(errmsg)")
            return
        }
        // ?에 데이터 매칭
        sqlite3_bind_text(stmt, 1, title, -1, SQLITE_TRANSIENT)
        sqlite3_bind_text(stmt, 2, content, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(stmt, 3, id)
        
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure updating : \(errmsg)")
            return
        }
        sqlite3_finalize(stmt)

    }//update
    
    
    // MARK: TF 글자 수 인식 textFieldDidChange
    @objc
    private func textFieldDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            switch textField {
            case tfMTitle:
                if let text = tfMTitle.text{
                    if text.count > tfMaxLength {
                        let maxIndex = text.index(text.startIndex, offsetBy: tfMaxLength)
                        let newString = String(text[text.startIndex..<maxIndex])
                        tfMTitle.text = newString
//                        print(newString)//@지워
                    }
                }
            default: return
            }
            // 버튼 활성화
            if tfMTitle.text?.isEmpty == false && tvMContent.text.isEmpty == false{
                EnterButton.isEnabled = true
            }else if tvMContent.text.isEmpty == false{
                EnterButton.isEnabled = true
            } else {
                EnterButton.isEnabled = false
            }
            // 글자수 라벨
            let count = String(tfMTitle.text!.count)
            lblTfCount.text = "\(count) / \(tfMaxLength)"
        }
    }//textFieldDidChange
    
    // MARK: 아이폰 모델에 따라 Max 글자수 조정 Function
    private func deviceTvCount() -> Int {
        let deviceName = UIDevice.current.name
        var length : Int
        
        switch deviceName {
        case "iPhone 3gs","iPhone 4","iPhone 4s","iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320
            length = 120
        case "iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone 12 mini","iPhone 13 mini","iPhone SE (2nd generation)", "iPhone SE (3rd generation)", "iPhone X","iPhone Xs","iPhone 11 Pro" : // 375
            length = 130
        case "iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14": // 390
            length = 135
        case "iPhone 14 Pro": // 393
            length = 135
        case "iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus","iPhone Xʀ","iPhone 11","iPhone Xs Max","iPhone 11 Pro Max": // 414
            length = 145
        case "iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus": // 428
            length = 150
        case "iPhone 14 Pro Max" : // 430
            length = 150
        default : //
            length = 130
        }
        return length
    }// Func deviceTvCount
    
    // MARK: 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//MonthlyPopUpViewController

// MARK: extension TF 글자수 제한
extension MonthlyPopUpViewController:UITextFieldDelegate, UITextViewDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tfCount = tfMTitle.text!.count
//        print(tfCount) //@지워야함
        // 백스페이스 제외
        if let char = string.cString(using: String.Encoding.utf8) {
                    let isBackSpace = strcmp(char, "\\b")
                    if isBackSpace == -92 {
                        return true
                    }
                }
        // 최대길이에 도달하면 키보드 내려감
        if tfCount == self.tfMaxLength{
            tfMTitle.resignFirstResponder()
        }
        return true
    }//textField
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let tvCount = tvMContent.text!.count
        // 백스페이스 제외
        if let char = text.cString(using: String.Encoding.utf8) {
                    let isBackSpace = strcmp(char, "\\b")
                    if isBackSpace == -92 {
                        return true
                    }
                }
        // 최대길이에 도달하면 키보드 내려감
        if tvCount == self.tvMaxLength{
            tvMContent.resignFirstResponder()
        }
        return true
    }//textview
    
    func textViewDidChange(_ textView: UITextView) {
         switch textView {
            case tvMContent:
                if let text = tvMContent.text{
                    if text.count > tvMaxLength {
                        let maxIndex = text.index(text.startIndex, offsetBy: tvMaxLength)
                        let newString = String(text[text.startIndex..<maxIndex])
                        tvMContent.text = newString
                        //                        print(newString)//@지워
                    }
                }
            default: return
            }
        // 버튼 활성화
        if tvMContent.text?.isEmpty == true {
            EnterButton.isEnabled = false
        }else {
            EnterButton.isEnabled = true
        }
        // 글자수 라벨 실시간 변경
        let count = String(tvMContent.text!.count)
        lblTvCount.text = "\(count) / \(tvMaxLength)"
    }//textViewDidChange
    
}//UITextFieldDelegate, UITextViewDelegate
