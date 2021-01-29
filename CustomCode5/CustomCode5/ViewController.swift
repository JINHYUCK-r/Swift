//
//  ViewController.swift
//  CustomCode5
//
//  Created by 류진혁 on 2021/01/29.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     /*
      let frame = CGRect(x: 30, y: 50, width: 150, height: 30)
      let csBtn = CSButton(frame: frame)
        self.view.addSubview(csBtn)
         */
      let csBtn = CSButton()
        csBtn.frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        self.view.addSubview(csBtn)
        /*
    let recBtn = CSButton(type: .rect)
        recBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(recBtn)
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
 */
        let circleBtn = CSButton(type: .circle)
         circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
         self.view.addSubview(circleBtn)
        
        //style의 didSet이 동작 
        circleBtn.style = .rect // 타원형태인것을 다시 사각형으로 지정 
        
    }
    
  
    


}

