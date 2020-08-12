//
//  SecondViewController.swift
//  ViewTransition
//
//  Created by 류진혁 on 2020/08/03.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var ageLable : UILabel!
    
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewContorooler의 view가 메모리에 로드됨")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInfomation.shared.name
        self.ageLable.text = UserInfomation.shared.age
        
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
    @IBAction func popToPrev(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func dismissmodal(){
        self.dismiss(animated: true, completion: nil)
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
