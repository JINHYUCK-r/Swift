//
//  ViewController.swift
//  ViewTransition
//
//  Created by 류진혁 on 2020/08/03.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField : UITextField!
    @IBOutlet weak var ageField : UITextField!
    
    @IBAction func touchUpSetButton(_sender : UIButton){
        UserInfomation.shared.name = nameField.text
        UserInfomation.shared.age = ageField.text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewContorooler의 view가 메모리에 로드됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController의 view가 화면에 보여질 예정")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ViewController의 view가 화면에 보여짐")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ViewController의 view가 화면에서 사라질 예정")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("ViewController의 view가 화면에서 사라짐")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("ViewController의 view가 subview를 레이아웃하려함")
    }
    
    override func viewDidLayoutSubviews() {
        print("ViewController의 view가 subview를 레이아웃 함")
    }


}

