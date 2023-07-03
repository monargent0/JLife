//
//  DailyPopUpViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/07/02.
//

import UIKit

class DailyPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면 half 사이즈
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
        }
        // Do any additional setup after loading the view.
    }
    // MARK: 버튼
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func btnEnter(_ sender: UIButton) {
    }
    // 아무곳이나 눌러 softkeyboard 지우기
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

}
