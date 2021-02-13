//
//  FrontViewController.swift
//  SideBar
//
//  Created by 류진혁 on 2021/02/13.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

//프로그램을 실행하면 이 화면이 시작페이지가 됨

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //revealViewController는 SWRevealViewController.m에 정의되어 있음
        if let revealVC = self.revealViewController(){
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        

    
    }
    


}
