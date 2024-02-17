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
    
    var imageArray = [UIImage?]()
    let colorList = ColorTheme().themeList
    let defaultsTheme = UserDefaults.standard // UserDefaults
    var selectColor = ""
    //defaultsTheme.set("색이름" ,forKey: "theme")
    // defaultsTheme.string(forKey: "theme") ?? "Blue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //-
        for i in 0..<colorList.count{
            let image = UIImage(named: colorList[i])
            imageArray.append(image)
        }
        //-
        themeImgView.image = UIImage(named: "Basic" )
        themeImgView.layer.cornerRadius = themeImgView.frame.width / 10
        themeImgView.layer.borderWidth = 4
        themeImgView.layer.borderColor = UIColor.systemGray5.cgColor
        themeImgView.clipsToBounds = true
        //-
        themePicker.dataSource = self
        themePicker.delegate = self
    }//
    




    
}//SettingViewController

// MARK: - Extension
extension SettingViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerview : UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        themeImgView.image = imageArray[row]
        selectColor = colorList[row]
    }
}
