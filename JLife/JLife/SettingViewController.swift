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
    
    var imageName = ["Basic.jpeg","Beige.jpeg","Coral.jpeg","CoolGray.jpeg","Blue.jpeg","Green.jpeg","Pink.jpeg","Purple.jpeg","WarmGray.jpeg","Yellow.jpeg"]
    var imageArray = [UIImage?]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<10{
            let image = UIImage(named: imageName[i])
            imageArray.append(image)
        }
        themeImgView.image = UIImage(named: "Basic.jpeg")
        themeImgView.layer.cornerRadius = 10
        themeImgView.layer.borderWidth = 4
        themeImgView.layer.borderColor = UIColor.systemGray5.cgColor
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

extension SettingViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerview : UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        themeImgView.image = imageArray[row]
    }
}
