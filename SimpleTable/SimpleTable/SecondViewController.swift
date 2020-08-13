//
//  SecondViewController.swift
//  SimpleTable
//
//  Created by 류진혁 on 2020/08/13.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var textToSet : String?
    @IBOutlet weak var textLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //이걸 viewDidLoad가 아니라 이걸 쓴이유는 실행하고 되돌아가면 초기화 되기때문
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textLabel.text = self.textToSet
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
