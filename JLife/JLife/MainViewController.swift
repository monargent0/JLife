//
//  MainViewController.swift
//  JLife
//
//  Created by 오정은 on 2022/11/03.
//

import UIKit

class MainViewController: UIViewController {

    //
    @IBOutlet weak var cvCalender: UICollectionView! // 달력 CollectionView
    @IBOutlet weak var svWeekDays: UIStackView!
    @IBOutlet weak var lblMonthYear: UILabel!
    @IBOutlet weak var svBottom: UIStackView!
    //
    var presentDate = Date()
    var allDateItems : [String] = []
    var items : (daysInMonth : Int, startWeekDay : Int) = (0,0)
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setMonth() // 달력 구성
        cvCalender.delegate = self
        cvCalender.dataSource = self
        CalenderHelper().addTopBorder(stackview: svWeekDays, borderWidth: 1.5 , borderColor: UIColor.darkGray.cgColor)
        CalenderHelper().addTopBorder(stackview: svBottom, borderWidth: 1.5, borderColor: UIColor.darkGray.cgColor)
    }
    
    // Previous Month
    @IBAction func btnPrevMonth(_ sender: UIButton) {
        presentDate = CalenderHelper().minusMonth(date: presentDate)
        setMonth()
    }
    // Next Month
    @IBAction func btnNextMonth(_ sender: UIButton) {
        presentDate = CalenderHelper().plusMonth(date: presentDate)
        setMonth()
    }
    
    //--- Setting Calendar Function ---
    func setMonth(){
        // Properties
        allDateItems.removeAll() // 초기화
        items.daysInMonth = CalenderHelper().daysInMonth(date: presentDate) // 현재 달 총 일수
        let firstOfMonth = CalenderHelper().firstOfMonth(date: presentDate) // 월 첫날
        items.startWeekDay = CalenderHelper().startWeekDay(date: firstOfMonth) // 달 시작 요일
        let daysInPrevMonth = CalenderHelper().daysInPrevMonth(date: presentDate) // 이전 달 총 일수
        
        // Contents
        var count:Int = 1
        while(count <= 42 ){ // 7days 6week
            if(count <= items.startWeekDay){
            // 이전 달
                allDateItems.append(String(daysInPrevMonth - items.startWeekDay + count))
            }else if(count - items.startWeekDay > items.daysInMonth){
            // 다음 달
                allDateItems.append(String( count % (items.daysInMonth + items.startWeekDay) ))
            }else{
            // 현재 달
                allDateItems.append(String(count - items.startWeekDay))
            }
            count += 1
        } // while
        
        lblMonthYear.text = CalenderHelper().yearString(date: presentDate) + "년 " + CalenderHelper().monthString(date: presentDate) + "월"
        
        // CollectionView Reload
        cvCalender.reloadData()
    }// func setMonth
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // MainViewController

//--- Collection View Cell ---
extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    // Cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allDateItems.count
    }
    // Cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarCell
        // Date
        cell.lblDay.text = allDateItems[indexPath.row]
        // Font Color
        switch indexPath.row {
        case 0..<items.startWeekDay:
            cell.lblDay.textColor = .lightGray
        case (items.daysInMonth + items.startWeekDay)..<allDateItems.count:
            cell.lblDay.textColor = .lightGray
        default:
            cell.lblDay.textColor = .darkGray
        }
        // Layer Color
        //
//        cell.backgroundColor = .cyan
        return cell
    }
} //-
extension MainViewController:UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.1
    }
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.2
    }
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 7 - 1
        let size = CGSize(width: width, height: width)
        
        return size
    }
} //-
