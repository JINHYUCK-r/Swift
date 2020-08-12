//
//  ThirdViewController.swift
//  LoginForm
//
//  Created by 류진혁 on 2020/08/07.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var telNum: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var signIn: UIButton!
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func goTO1(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindVC1", sender: self)
    }
    
    let dateFormatter : DateFormatter = {
        let formmater : DateFormatter = DateFormatter()
        formmater.dateStyle = .medium
        return formmater
    }()
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.dateLabel.text = dateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func popSecondView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
