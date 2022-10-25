//
//  ViewController.swift
//  FontChangeApp
//
//  Created by 오정은 on 2022/10/15.
//

import UIKit

class ViewController: UIViewController {
/*
 1. 폰트 ttf파일을 프로젝트에 복사한다.
    + 복사할때 copy if needed 체크하고, Add target에서 프로젝트명 체크한다.
 2. info.plist에 폰트파일명을 추가해준다.
    2.1 Fonts provided by application 생성
    2.2 item0 의 Value에 폰트 파일명, 확장자까지 입력 (추가하는 폰트 갯수 만큼 item 추가)
 3. 파일리스트에서 xcode로고가 달린 프로젝트명 클릭,
    Bulid Phases 탭 - Copy Bundle Resources에 폰트파일이 있는지 확인한다.
 4. 폰트 사용하기
    4.1 Main에서 Font 옵션 Custom에서 지정해준다.
    4.2 Viewcontroller에서 UIFont 코드를 이용해서 변경한다.
 */
    @IBOutlet weak var lblText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Font 이름 확인하기
//        UIFont.familyNames.sorted().forEach { familyName in
//            print("Font FamilyName : \(familyName)")
//            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
//                print("FontName : \(fontName)")
//            }
//            print("------")
//        }//
    }

    
    @IBAction func btnDokdo(_ sender: UIButton) {
        lblText.font = UIFont(name: "EastSeaDokdo-Regular" , size: 20)
    }
    
    @IBAction func btnGmarket(_ sender: UIButton) {
        lblText.font = UIFont(name: "GmarketSansTTFMedium" , size: 20)
    }
    
    @IBAction func btnCafe24(_ sender: UIButton) {
        lblText.font = UIFont(name: "Cafe24Ssurroundair" , size: 20)
    }
    
} // ViewController

/*
 사용한 폰트
 Font FamilyName : Cafe24 Ssurround air
 FontName : Cafe24Ssurroundair <- **
 
 Font FamilyName : East Sea Dokdo
 FontName : EastSeaDokdo-Regular <- **
 
 Font FamilyName : Gmarket Sans TTF
 FontName : GmarketSansTTFMedium <- **
 */
