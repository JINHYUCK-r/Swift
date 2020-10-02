//
//  ViewController.swift
//  DataMove
//
//  Created by 류진혁 on 2020/10/02.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var isUpdate: UISwitch!
    
    @IBOutlet weak var interval: UIStepper!
    
    
    @IBOutlet weak var isUpdateText: UILabel!
    
    
    @IBOutlet weak var intervalText: UILabel!
    
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.isUpdateText.text = "갱신함"
        }else{
            self.isUpdateText.text = "갱신하지않음"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    
    //segue를 활용한 데이터 전달
    @IBAction func onPerformSegue(_ sender: Any) {
          self.performSegue(withIdentifier: "ManualSubmit", sender: self)
      }
      
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //세그웨이 목적지의 정보를 가져옴
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else{
            return
        }
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
    }

    
    @IBAction func onSubmit(_ sender: Any) {
        //목적지 지정( VC2  인스턴스 생성)
        guard let rvc = self.storyboard?.instantiateViewController(identifier: "RVC") as? ResultViewController else{
            return
        }
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        //화면이동
        //self.present(rvc,animated: true)
        
        //네비게이션을 활용한 화명이동
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

