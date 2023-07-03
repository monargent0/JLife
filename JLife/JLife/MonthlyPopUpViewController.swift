//
//  MonthlyPopUpViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/27.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기종별 textview길이 제한
        tvMaxLength = deviceTvCount()
        // 글자수 라벨
        lblTfCount.text = "\(String(tfMTitle.text!.count)) / \(tfMaxLength)"
        lblTvCount.text = "\(tvMContent.text.count) / \(tvMaxLength)"
        // 화면 half 사이즈
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
        }
        // 초기 수정 버튼 비활성화
        EnterButton.isEnabled = false
        // 인식 NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: nil)
        // Delegate
        tfMTitle.delegate = self
        tvMContent.delegate = self
        // DailyText Border
        tfMTitle.layer.borderWidth = 0.7
        tfMTitle.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tfMTitle.layer.cornerRadius = 5
        tvMContent.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        tvMContent.layer.borderWidth = 0.7
        tvMContent.layer.cornerRadius = 5
    }
    
    // MARK: 버튼
    // 취소
    @IBAction func btnBack(_ sender: UIButton) {
        dismiss(animated: true)
    }
    // 확인
    @IBAction func btnEnter(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // MARK: 아무곳이나 눌러 softkeyboard 지우기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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
        // 글자수 라벨
        let count = String(tvMContent.text!.count)
        lblTvCount.text = "\(count) / \(tvMaxLength)"
    }
    
}//UITextFieldDelegate, UITextViewDelegate
