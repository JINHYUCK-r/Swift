//
//  ViewController.swift
//  SampleWebView
//
//  Created by 류진혁 on 2020/08/17.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit
import WebKit //웹뷰를 사용할때는 임포트해주어야함

class ViewController: UIViewController {

   

    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
      //웹뷰 사용법
      //1. url 스트링을 준비한다.(웹주소같은)
      //2. url string을 url을 거쳐 urlRequest로 만들기
     // 3. urlRequest를 웹뷰로 뿌린다
     let urlString = "https://www.google.com" //1번과정
        if let url = URL(string: urlString){
             //unwrap과정, nil이 아닐때 실행됨
            let urlReq = URLRequest(url: url)  //urlString을 url로 바꿔주는 역할. 2번과정
            WebViewMain.load(urlReq) //3번과정
        }
    
        
        
       }
}

