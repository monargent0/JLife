//
//  MainViewController.swift
//  JLife
//
//  Created by 오정은 on 2023/06/22.
//

import UIKit

class MainViewController: UIViewController {

    /* 스토리보드와 연결 */
    @IBOutlet weak var cvCalendar: UICollectionView! // 달력
    @IBOutlet weak var lblDateTitle: UILabel! // 상단 년월
    @IBOutlet weak var svWeek: UIStackView! // 상단 요일
    
    /* 변수 선언 */
    var presentDate = Date() // 현재
    var allDateItems : [String] = [] //
    var items : (daysInMonth : Int , startWeekDay : Int) = (0,0) //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvCalendar.dataSource = self
        cvCalendar.delegate = self
        setMonth()
        // Do any additional setup after loading the view.
//        self.view.addSubview(cvCalendar)
        
        cvCalendar.translatesAutoresizingMaskIntoConstraints = false
        cvCalendar.widthAnchor.constraint(equalToConstant: 393).isActive = true
        cvCalendar.heightAnchor.constraint(equalToConstant: 340).isActive = true
        cvCalendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cvCalendar.topAnchor.constraint(equalTo:svWeek.bottomAnchor,constant: 0).isActive = true
    }
    
    /* 버튼 */
    
    /* Setting Calendar */
    func setMonth(){
        // Properties
        allDateItems.removeAll() // 초기화
        items.daysInMonth = CalendarBuilder().daysInMonth(date: presentDate) // 현재 달 일수
        let firstOfMonth = CalendarBuilder().firstOfMonth(date: presentDate) // 월의 첫날
        items.startWeekDay = CalendarBuilder().startWeekDay(date: firstOfMonth) // 달 시작 요일
        let daysInPrevMonth = CalendarBuilder().daysInPrevMonth(date: presentDate) // 이전 달 일수
        
        // Calendar Contents
        var count:Int = 1
        while(count <= 42){ // 7 days 6 week
            if(count <= items.startWeekDay){ // 이전 달
                allDateItems.append(String(daysInPrevMonth - items.startWeekDay + count))
            }else if(count - items.startWeekDay > items.daysInMonth){ // 다음 달
                allDateItems.append(String(count % (items.daysInMonth + items.startWeekDay)))
            }else{ // 현재 달
                allDateItems.append(String(count - items.startWeekDay))
            }
            count += 1
        } // while
        
        // Title
        lblDateTitle.text = CalendarBuilder().yearString(date: presentDate) + "년 " + CalendarBuilder().monthString(date: presentDate) + "월"
        
        // CollectionView Reload
        cvCalendar.reloadData()
    }// Func setMonth

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //MainViewController

/* Collection View Cell */
extension MainViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    // Cell 개수
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
        return cell
    }
}// Delegate, DataSouce

extension MainViewController:UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 7 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
    //
    
}// DelegateFlowLayout
