//
//  TodoListCell.swift
//  JLife
//
//  Created by 오정은 on 2023/07/07.
//

import UIKit

class TodoListCell: UICollectionViewCell {
    // story board
    @IBOutlet weak var checkBtnOut: UIButton!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    @IBAction func btnComplete(_ sender: UIButton) {
        print("btnTodo")
    }
}
