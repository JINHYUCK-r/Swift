//
//  ViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultAlerBtn = UIButton(type: .system)
        defaultAlerBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlerBtn.center.x = self.view.frame.width/2
        defaultAlerBtn.setTitle("기본 실행창", for: .normal)
        defaultAlerBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        self.view.addSubview(defaultAlerBtn)
    }
    
    @objc func defaultAlert(_ sender : Any){
        let alert = UIAlertController(title: nil, message: "기본 메세지가 들어가는곳", preferredStyle: .alert)
        //title,message nil로 지정하면 그 부분들이 없어지고 알림창 밑에 뷰컨트롤러 부분이 확장된다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        //알림창에 들어간 뷰 컨트롤러
        let v = UIViewController()
        v.view.backgroundColor = .red
        //contentViewController는 프라이빗 api이기때문에 자동완성을 지원하지 않는다
        alert.setValue(v, forKey: "contentViewController") //값을 넣고 속성의 이름을 넣는다
        
        self.present(alert, animated: false)
        
    }


}

