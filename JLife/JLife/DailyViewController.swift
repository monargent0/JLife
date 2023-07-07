//
//  DailyViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit

class DailyViewController: UIViewController , UITextViewDelegate {
    // MARK: 스토리보드 연결
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tvDaily: UITextView!

    // MARK: 변수선언
    
    // MARK: DB 변수선언
    var todoID = 0
    var mvYear = 0
    var mvMonth = 0
    var mvDay = 0
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Date label
        let dateComponent = DateComponents(year:mvYear,month: mvMonth,day: mvDay)
        let date = Calendar.current.date(from: dateComponent)
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "ko_kr")
        dateFormat.dateFormat = "M월 d일 EEEE"
        lblDate.text = dateFormat.string(from: date!)
        
        // DailyText Border
        tvDaily.layer.borderColor = UIColor.lightGray.cgColor
        tvDaily.layer.borderWidth = 1.0
        tvDaily.layer.cornerRadius = 5
        
        // modal dismiss notification
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissDailyNotification(_ :)), name: Notification.Name("DidDismissDailyViewController"), object: nil)
    }
    
    
    // MARK: segue DailyyView로 값 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let dailyPopUpViewController = segue.destination as? DailyPopUpViewController
        if segue.identifier == "sgDaily"{
//            let date = lblDateTitle.text?.components(separatedBy: " ")
//            monthlyPopUpViewController?.year = date![0]
//            monthlyPopUpViewController?.month = date![1]
//            monthlyPopUpViewController?.mvTitle = lblMonthlyTitle.text!
//            monthlyPopUpViewController?.mvContent = tvMContent.text == "+ 버튼을 눌러보세요!" ? "" : tvMContent.text
//            monthlyPopUpViewController?.existence = monthlyExistence // DB select 존재 여부
//            monthlyPopUpViewController?.monthlyID = monthlyBundle.isEmpty ? 0 : monthlyBundle[0].id
        }
    }// prepare
    
    // MARK: DISMISS 후 화면 재로딩
    @objc
    private func didDismissDailyNotification(_ notification:Notification) {
//         readMonthlyValues()
//        if monthlyExistence == true{
//            lblMonthlyTitle.text = monthlyBundle[0].title
//            tvMContent.text = monthlyBundle[0].content
//        }

    }//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
