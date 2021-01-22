//
//  SecondViewController.swift
//  CustomCode2
//
//  Created by 류진혁 on 2021/01/21.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "두번째 탭"
        title.textColor = .red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit() //먼저 설정하고 가운데 맞추는게 좋다
        title.center.x = self.view.frame.width/2
        self.view.addSubview(title)
        
      
   
        
    }
    



}
