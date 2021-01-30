//
//  CSStepperViewController.swift
//  CustomCode5
//
//  Created by 류진혁 on 2021/01/30.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class CSStepperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        self.view.addSubview(stepper)
        // let v = stepper.value stepper의 현재값
        //ValueChange 이벤트가 발생하면 logging메소드가 호출되도록
        stepper.addTarget(self, action: #selector(logging(_:)), for: .valueChanged)
    }
    @objc func logging(_ sender : CSStepper){
        NSLog("현재 스테퍼의 값은 \(sender.value)입니다.")
    }

}
