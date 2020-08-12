//
//  ViewController.swift
//  TapGesture
//
//  Created by 류진혁 on 2020/08/07.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    /*
    //스토리보들에서 만든 탭제스쳐를 연결하기
    @IBAction func tapView(_sender : UITapGestureRecognizer){
        self.view.endEditing(true)
    } */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        //코드만으로 연결하기
        let tapGesture : UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_sender:)))
        self.view.addGestureRecognizer(tapGesture) */
        
       //딜리게이트 활용
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        self.view.endEditing(true)
        return false
        
    }

}

