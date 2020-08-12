//
//  ViewController.swift
//  DatePicker
//
//  Created by 류진혁 on 2020/08/06.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker : UIDatePicker!
    @IBOutlet weak var dateLabel :
    UILabel!
    
    let dateFormatter: DateFormatter = {
        let formatter : DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        //원하는대로 날짜표현형식을 지정해 줄수 있음
        formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        return formatter
    }()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //datepicker의 값이 바뀔때마다 did액션이 발생하도록하는코드. 스토리보드에서 연결하지않고 코드로 직접만든것
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerChanged(_:)), for: UIControl.Event.valueChanged)
    }

    @IBAction func didDatePickerChanged(_ sender: UIDatePicker) {
        print("value changed")
        
        let date : Date =  self.datePicker.date//이렇게 받아와도 됨.sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.dateLabel.text = dateString
    }
    
}

