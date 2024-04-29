//
//  AlertViewController.swift
//  JLife
//
//  Created by OoO on 2023/07/10.
//

import UIKit

class AlertViewController: UIViewController {
    
    let slider = UISlider()

    
    var sliderValue:Float{
        if slider.value - Float(Int(slider.value)) >= 0.5{
            return Float(Int(self.slider.value)) + 0.5
        } else {
            return Float(Int(self.slider.value))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img1 = UIImageView()
        let img2 = UIImageView()
        let img3 = UIImageView()
        let img4 = UIImageView()
        let img5 = UIImageView()
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = 5
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 33)
        self.view.addSubview(self.slider)
        
        img1.image = UIImage(systemName: "star")
        img1.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        img1.tag = 1
        self.view.addSubview(img1)
        
        img2.image = UIImage(systemName: "star")
        img2.frame = CGRect(x: 34, y: 0, width: 33, height: 33)
        img2.tag = 2
        self.view.addSubview(img2)
        
        img3.image = UIImage(systemName: "star")
        img3.frame = CGRect(x: 68, y: 0, width: 33, height: 33)
        img3.tag = 3
        self.view.addSubview(img3)
        
        img4.image = UIImage(systemName: "star")
        img4.frame = CGRect(x: 102, y: 0, width: 33, height: 33)
        img4.tag = 4
        self.view.addSubview(img4)
        
        img5.image = UIImage(systemName: "star")
        img5.frame = CGRect(x: 136, y: 0, width: 33, height: 33)
        img5.tag = 5
        self.view.addSubview(img5)
        
        slider.addTarget(self, action: #selector(onChangeValue(_ :)), for: .valueChanged)
        
        self.slider.minimumTrackTintColor = .clear
        self.slider.maximumTrackTintColor = .clear
        self.slider.thumbTintColor = .clear
//
//        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height + 10) // 에러가 나서 사용하지 못함
        // Do any additional setup after loading the view.
    }
    
    @objc func onChangeValue(_ sender: UISlider){
        let floatValue = floor(sender.value * 10) / 10
//        print(floatValue , sliderValue)
        for index in 1...5 {
            if let sliderImage = view.viewWithTag(index) as? UIImageView{
                if Float(index) <= floatValue {
                    sliderImage.image = UIImage(systemName: "star.fill")
//                    sliderImage.tintColor = .darkText
                }else if Float(index) - floatValue <= 0.5 {
                    sliderImage.image = UIImage(systemName: "star.lefthalf.fill")
                }else{
                    sliderImage.image = UIImage(systemName: "star")
                }
            }
        }
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
