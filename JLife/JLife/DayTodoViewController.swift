//
//  DayTodoViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/07/03.
//

import UIKit

class DayTodoViewController: UIViewController {
    // MARK: 스토리보드 연결
    
    
    // MARK: 변수 선언
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    // MARK: 버튼
    // 취소
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    // 추가
    @IBAction func btnAdd(_ sender: UIButton) {
        
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
