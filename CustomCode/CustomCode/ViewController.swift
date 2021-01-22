//
//  ViewController.swift
//  CustomCode
//
//  Created by 류진혁 on 2021/01/15.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        btn.setTitle("텍스트버튼", for: .normal)
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        
        
    }
    @objc func btnOnClick(_ sender : Any){
        if let btn = sender as? UIButton{
            btn.setTitle("클릭되었습니다.", for: .normal)
        }
        
    }
    
  

}

