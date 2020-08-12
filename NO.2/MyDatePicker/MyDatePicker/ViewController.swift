//
//  ViewController.swift
//  MyDatePicker
//
//  Created by 류진혁 on 2020/08/06.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var dateLabel : UILabel!
    let dateFormatter : DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        /* 날짜를 보여주는 정해져있는 형식
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        */
        //내가 원하는 형식으로 직접 지정해 줄수있음
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    @IBAction func didDatePickerValueChanged(_sender : UIDatePicker){
        print("value change")
        
        let date : Date = self.datePicker.date
        let dateString = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_sender:)), for: UIControl.Event.valueChanged)
    }

   
    
}

