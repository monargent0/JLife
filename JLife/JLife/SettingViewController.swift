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
    @IBOutlet weak var nowThemeLbl: UILabel!
    
    // MARK: 변수 선언
    var imageArray = [UIImage?]()
    let colorList = ColorTheme().themeList
    let colorNameKR = ColorTheme().colorName
    let defaultsTheme = UserDefaults.standard // UserDefaults
    var nowTheme : String = "Basic" // 사용자 설정 테마
    var selectColor = "Basic" // 새로 선택한 테마
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        nowTheme = defaultsTheme.string(forKey: "theme") ?? "Basic"
        //- UI이미지 로딩
        for i in 0..<colorList.count{
            let image = UIImage(named: colorList[i])
            imageArray.append(image)
        }
        //- 이미지뷰
        themeImgView.image = UIImage(named: "Basic" )
        themeImgView.layer.cornerRadius = themeImgView.frame.width / 10
        themeImgView.layer.borderWidth = 4
        themeImgView.layer.borderColor = UIColor.systemGray5.cgColor
        themeImgView.clipsToBounds = true
        //- 피커뷰
        themePicker.dataSource = self
        themePicker.delegate = self
        //-
        nowThemeLbl.text = "현재 테마 색상 : \(colorNameKR[nowTheme]!.kr)"
    }

    // MARK: 적용 버튼 동작
    @IBAction func btnSave(_ sender: UIButton) {
        defaultsTheme.set(selectColor ,forKey: "theme")
        nowThemeLbl.text = "현재 테마 색상 : \(colorNameKR[selectColor]!.kr)"
    }

    
}//SettingViewController

// MARK: - Extension
extension SettingViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerview : UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        themeImgView.image = imageArray[row]
        selectColor = colorList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Cafe24Ssurroundair", size: 17)
            label.text = colorNameKR[colorList[row]]?.kr // 한글색상명
            label.textAlignment = .center
            return label
        }
    
}// extension
