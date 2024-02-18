//
//  ColorTheme.swift
//  JLife
//
//  Created by 오정은 on 2024/02/17.
//

import Foundation

struct ColorTheme {
    let themeList = ["Basic","Beige","Yellow","Green","Blue","Pink","Purple","Coral","CoolGray","WarmGray"]
    
    typealias theme = (mainColor:String , border:String , kr:String)
    var colorName : [String : theme] = [
        "Basic":("ScoreColor","PinkColor","기본"),"Beige":("BeigeTheme","BeigeBorder","베이지"),
        "Yellow":("YellowTheme","YellowBorder","연노랑"),"Green":("GreenTheme","GreenBorder","연녹색"),
        "Blue":("BlueTheme","BlueBorder","하늘색"),"Pink":("PinkTheme","PinkBorder","분홍색"),
        "Purple":("PurpleTheme","PurpleBorder","연보라"),"Coral":("CoralTheme","CoralBorder","다홍색"),
        "CoolGray":("CoolGrayTheme","CoolGrayBorder","청회색"),
        "WarmGray":("WarmGrayTheme","WarmGrayBorder","적회색")]
}

/*  ---사용처---
 // in SettingVC
 let colorList = ColorTheme().themeList
 
 // in MainVC
 let colorNameList = ColorTheme().colorName
 cell.backgroundColor = UIColor(named: colorNameList["Basic"]!.mainColor)
 cell.layer.borderColor = UIColor(named: colorNameList["Basic"]!.border )?.cgColor
*/
