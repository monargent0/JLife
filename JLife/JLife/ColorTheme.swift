//
//  ColorTheme.swift
//  JLife
//
//  Created by 오정은 on 2024/02/17.
//

import Foundation

struct ColorTheme {
    let themeList = ["Basic","Beige","Yellow","Green","Blue","Pink","Purple","Coral","CoolGray","WarmGray"]
    
    typealias theme = (mainColor:String , border:String)
    var colorName : [String : theme] = [
        "Basic":("ScoreColor","PinkColor"),"Beige":("BeigeTheme","BeigeBorder"),
        "Yellow":("YellowTheme","YellowBorder"),"Green":("GreenTheme","GreenBorder"),
        "Blue":("BlueTheme","BlueBorder"),"Pink":("PinkTheme","PinkBorder"),
        "Purple":("PurpleTheme","PurpleBorder"),"Coral":("CoralTheme","CoralBorder"),
        "CoolGray":("CoolGrayTheme","CoolGrayBorder"),"WarmGray":("WarmGrayTheme","WarmGrayBorder")]
}

/*  ---사용처---
 // in SettingVC
 let colorList = ColorTheme().themeList
 
 // in MainVC
 let colorNameList = ColorTheme().colorName
 cell.backgroundColor = UIColor(named: colorNameList["Basic"]!.mainColor)
 cell.layer.borderColor = UIColor(named: colorNameList["Basic"]!.border )?.cgColor
*/
