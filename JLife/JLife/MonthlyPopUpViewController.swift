//
//  MonthlyPopUpViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/27.
//

import UIKit

class MonthlyPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면 half 사이즈
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]
        }
        // Do any additional setup after loading the view.
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