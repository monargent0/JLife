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
    @IBOutlet weak var pickerOut: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var lblTvCount: UILabel!
    @IBOutlet weak var lblSelectTime: UILabel!
    @IBOutlet weak var picker: UIDatePicker!
    
    // MARK: 변수 선언
    var tvMaxLength = 50
    let DidDismissTodoAddViewController:Notification.Name = Notification.Name("DidDismissTodoAddViewController")
    
    //
    var db : OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면 setting
        lblTvCount.text = "0 / \(tvMaxLength)"
        addButton.isEnabled = false
//        picker.isHidden = true
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
        formatter.dateFormat = "hh시 mm분"
        let time = formatter.string(from: senderTP.date)
        lblSelectTime.text = "선택 시간: \(time)"
    }
    
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
