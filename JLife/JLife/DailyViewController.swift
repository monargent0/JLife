//
//  DailyViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit

class DailyViewController: UIViewController , UITextViewDelegate {

    @IBOutlet weak var tvDaily: UITextView!
//    let dot = UIImageView(image: UIImage(named: "dotLineBox.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tvDaily.addSubview(dot)
//        tvDaily.bringSubviewToFront(dot)
//        dot.frame.size = CGSize(width: 273.0, height: 100.0)
        
        // DailyText Border
        tvDaily.layer.borderColor = UIColor.lightGray.cgColor
        tvDaily.layer.borderWidth = 1.0
        tvDaily.layer.cornerRadius = 5
        // 글자수 제한
        tvDaily.delegate = self

    }
    
    func textViewDidChange(_ textView: UITextView) {
        if tvDaily.text.count > 30{
            tvDaily.deleteBackward()
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
