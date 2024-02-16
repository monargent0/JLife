//
//  SettingViewController.swift
//  JLife
//
//  Created by 오정은 on 2024/02/16.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var themeImgView: UIImageView!
    @IBOutlet weak var themePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //-
        themePicker.dataSource = self
        themePicker.delegate = self
    }//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//SettingViewController

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate{
        
}
