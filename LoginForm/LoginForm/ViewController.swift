//
//  ViewController.swift
//  LoginForm
//
//  Created by 류진혁 on 2020/08/07.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginId: UITextField!
    @IBOutlet weak var loginPw: UITextField!
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func unwindVC1(segue: UIStoryboardSegue){}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

