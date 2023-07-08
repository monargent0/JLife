//
//  DayTodoViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/07/03.
//

import UIKit
import SQLite3

class DayTodoViewController: UIViewController {
    
    // MARK: 스토리보드 연결
    @IBOutlet weak var tvTodo: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var lblTvCount: UILabel!
    @IBOutlet weak var lblSelectTime: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var timeSwitch: UISwitch!
    
    // MARK: 변수 선언
    var tvMaxLength = 50
    let DidDismissTodoAddViewController:Notification.Name = Notification.Name("DidDismissTodoAddViewController")
    // 수정화면일때 받아올 값
    var timeExist = false
    var selectedTime = "선택 안함"
    
    //
    var db : OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvMaxLength = deviceTvCount()
        // 화면 setting
        addButton.isEnabled = false
        lblTvCount.text = "0 / \(tvMaxLength)"
        lblSelectTime.text = "일정 시간 : \(selectedTime)"
        timeSwitch.isOn = timeExist
        timeSelec(timeExist)
        //delegate
        tvTodo.delegate = self
        // 레이아웃
        tvTodo.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tvTodo.layer.borderWidth = 0.7
        tvTodo.layer.cornerRadius = 5
        // SQLite
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "TodoData.sqlite")
        if sqlite3_open(fileURL.path(percentEncoded: false), &db) != SQLITE_OK{
            print("error opening todo database")
        }
    }
    // MARK: 버튼
    // switch
    @IBAction func timeSwitchAction(_ sender: UISwitch) {
        timeSelec(timeSwitch.isOn)
    }
    // 취소
    @IBAction func btnCancel(_ sender: UIButton) {
        NotificationCenter.default.post(name: DidDismissTodoAddViewController, object: nil)
        dismiss(animated: true)
    }
    // 추가
    @IBAction func btnAdd(_ sender: UIButton) {
        // insert
        NotificationCenter.default.post(name: DidDismissTodoAddViewController, object: nil)
        dismiss(animated: true)
    }
    // MARK: TimePicker
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let senderTP = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시 mm분"
        let time = formatter.string(from: senderTP.date)
        selectedTime = time
        lblSelectTime.text = "일정 시간: \(time)"
    }
    
    private func timeSelec(_ switchState : Bool) {
        if switchState == false {
            picker.isHidden = true
            selectedTime = "선택 안함"
            lblSelectTime.text = "일정 시간: \(selectedTime)"
        }else {
            picker.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "a h시 mm분"
            selectedTime = formatter.string(from: picker.date)
            lblSelectTime.text = "일정 시간: \(selectedTime)"
        }
    }// timeSelec
    
    // MARK: 아이폰 모델에 따라 Max 글자수 조정 Function
    private func deviceTvCount() -> Int {
        let deviceName = UIDevice.current.name
        var length : Int
        
        switch deviceName {
        case "iPhone 3gs","iPhone 4","iPhone 4s","iPhone 5","iPhone 5c","iPhone 5s","iPhone SE (1st generation)" : // 320
            length = 65
        case "iPhone 6","iPhone 6s","iPhone 7","iPhone 8","iPhone 12 mini","iPhone 13 mini","iPhone SE (2nd generation)", "iPhone SE (3rd generation)", "iPhone X","iPhone Xs","iPhone 11 Pro" : // 375
            length = 72
        case "iPhone 12","iPhone 12 Pro","iPhone 13","iPhone 13 Pro","iPhone 14": // 390
            length = 76
        case "iPhone 14 Pro": // 393
            length = 76
        case "iPhone 6 Plus","iPhone 6s Plus","iPhone 7 Plus","iPhone 8 Plus","iPhone Xʀ","iPhone 11","iPhone Xs Max","iPhone 11 Pro Max": // 414
            length = 84
        case "iPhone 12 Pro Max","iPhone 13 Pro Max","iPhone 14 Plus": // 428
            length = 88
        case "iPhone 14 Pro Max" : // 430
            length = 88
        default : //
            length = 75
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

}//DayTodoViewController
// MARK: extension TV
extension DayTodoViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let tvCount = tvTodo.text!.count
        // 백스페이스
        if let char = text.cString(using: String.Encoding.utf8){
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }//
        if tvCount == self.tvMaxLength ||  text == "\n"{
            tvTodo.resignFirstResponder()
        }
        return true
    }// textview shouldchange
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
           case tvTodo:
               if let text = tvTodo.text{
                   if text.count > tvMaxLength {
                       let maxIndex = text.index(text.startIndex, offsetBy: tvMaxLength)
                       let newString = String(text[text.startIndex..<maxIndex])
                       tvTodo.text = newString
                       //print(newString)//@지워
                   }
               }
           default: return
           }//
        // button 활성화
        if tvTodo.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            addButton.isEnabled = false
        }else {
            addButton.isEnabled = true
        }
        // 글자수 라벨 실시간
        let count = String(tvTodo.text!.count)
        lblTvCount.text = "\(count) / \(tvMaxLength)"
    }// textview didchange
}
