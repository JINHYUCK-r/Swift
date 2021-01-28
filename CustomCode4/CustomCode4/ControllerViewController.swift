//
//  ControllerViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ControllerViewController: UIViewController {
   private let slider = UISlider()

    //스라이더 객체의 값을 읽어오는 연산 프로퍼티 
    var sliderValue : Float{
        return self.slider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        slider.minimumValue = 0
        slider.maximumValue = 100
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height:  self.slider.frame.height + 10)
        
    }
    

}
