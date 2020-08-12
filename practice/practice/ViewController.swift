//
//  ViewController.swift
//  practice
//
//  Created by 류진혁 on 2020/08/03.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //서브뷰 생성
        let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
        let subView = UIView(frame : frame)
        
        //서브뷰의 색상
        subView.backgroundColor = UIColor.green
        
        //서브뷰 추가
        view.addSubview(subView)
        
        //서브뷰 제거
        subView.removeFromSuperview()
        
        
    }
    


}

