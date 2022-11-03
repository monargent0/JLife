//
//  ViewController.swift
//  CalenderApp_J
//
//  Created by 오정은 on 2022/10/15.
//
// 변수 선언이 중복되는데 줄일 수 있는 방법 찾아보기!
// 글자색, 동그라미 배경 왔다갔다 하는거 해결
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblMonth: UILabel!
    
    @IBOutlet weak var stView: UIStackView!
    
    var selectedDate = Date() // Today
    var totalDate : [String] = [] // 출력될 달력 일
    var infos : (days:Int, startDays:Int) = (0,0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 달력 구성
        setMonthView()
        
        // CollectionView 구성
        collectionView.delegate = self
        collectionView.dataSource = self

        // 상단 테두리
        self.stView.addTopBorder()
        
        
    }//
    
    // 달력 표시
    func setMonthView(){
        totalDate.removeAll()
        
        // 총 일수
        let daysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        // 월 첫날
        let firstDayOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        // 첫날이 무슨 요일인지 0 Sun ~ 6 Sat
        let startingSpaces = CalenderHelper().weekDay(date: firstDayOfMonth)
        // 이전달 총 일수
        let prevDays = CalenderHelper().prevDays(date: selectedDate)
        
        var count : Int = 1
        while(count <= 42){ // 7일 6줄 : 42칸 (index 0~41)
            if (count <= startingSpaces){ // 이전 달 일부
                totalDate.append(String(prevDays - startingSpaces + count))
            }else if(count - startingSpaces > daysInMonth){ // 다음 달 일부
                totalDate.append(String(count % (daysInMonth + startingSpaces)))
            }else{ // 현재 달의 일 표시
                totalDate.append(String(count - startingSpaces))
            }
            count += 1
        }//
        
        //
        infos.days = daysInMonth
        infos.startDays = startingSpaces
        
        // 상단에 년월 표시
        lblMonth.text =  CalenderHelper().yearString(date: selectedDate) + "년 "
        + CalenderHelper().monthString(date: selectedDate) + "월"
        
        // 새로고침
        collectionView.reloadData()
    }//
    
    // 이전 달
    @IBAction func btnPrevMonth(_ sender: UIButton) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    // 다음 달
    @IBAction func btnNextMonth(_ sender: UIButton) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
}// ViewController

// --- Cell 구성 extension Start---
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    // Cell 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalDate.count
    }
    // Cell 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarCell
        // info.days : 해당 달 총 일수 , info.startDays : 해당 달 첫 요일
        
       // 해당 달 일때
        if !((indexPath.row < infos.startDays) || (indexPath.row >= infos.days + infos.startDays)) {
//            cell.backgroundColor = .placeholderText // 배경색
//            cell.contentView.layer.cornerRadius = cell.frame.height / 2 // 원형모양
            
            cell.lblDay.textColor = .darkGray
//            cell.backgroundColor =  UIColor(red: 245/255, green: 94/255, blue: 97/255, alpha: CGFloat( Double(infos.days) / 100.0) )
        }else{ // 해당 달 아닐때
            
//            cell.contentView.layer.backgroundColor = UIColor.lightGray.cgColor
            cell.lblDay.textColor = .lightGray
            
        }
        // 색상 조건 테스트
        if Int(totalDate[indexPath.row])! % 5 == 0 {
            cell.backgroundColor = UIColor(red: 245/255, green: 94/255, blue: 97/255, alpha: CGFloat(Double(indexPath.item * 3) / 100.0) )
        }
        //
        cell.lblDay.text = totalDate[indexPath.row] // row, item 다 가능
        
        return cell
    }
    // Cell Click 했을때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 클릭시 출력 테스트
        print(totalDate[indexPath.row] + " & \(indexPath.startIndex)" )
        print(totalDate[indexPath.item].trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        collectionView.reloadData()
    }
}//extension

extension ViewController: UICollectionViewDelegateFlowLayout{
    // 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    // Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 7 - 1
//        let height = (collectionView.frame.size.height) / 7 - 1
        let size = CGSize(width: width, height: width)
        
        return size
    }
}//extension
// --- Cell 구성 extension End ---
extension UIStackView {
    func addTopBorder(){
       let topLine = CALayer()
       topLine.frame = CGRect(x: (self.frame.size.height / 4) , y: 0 , width: UIScreen.main.bounds.width - (self.frame.size.height / 2), height: 1.5)
       // (x,y) (0,0) 왼쪽위상단, width : 폭, height : 두꼐
       // 양쪽에 (self.frame.size.height / 4) 만큼 공백 만들어줌
       topLine.backgroundColor = UIColor.darkGray.cgColor
       layer.addSublayer(topLine)
//       layer.masksToBounds = true // trye : 내 영역(Layer) 이외 영역의 Sub Layer는 Draw 하지 않는다
   }
}
