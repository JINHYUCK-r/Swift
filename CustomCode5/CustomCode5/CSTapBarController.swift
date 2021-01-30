//
//  CSTapBarController.swift
//  CustomCode5
//
//  Created by 류진혁 on 2021/01/30.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class CSTapBarController : UITabBarController{
    
    let csView = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    
    override func viewDidLoad() {
        //초기화면은 첫번째
        self.onTabBarIem(self.tabItem01)
        //기본탭바를 보이지않게하기
        self.tabBar.isHidden = true
        
        let width = self.view.frame.width
        let height :CGFloat = 50
        let x :CGFloat = 0
        let y = self.view.frame.height-height
        
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = .brown
        //탭바가 담길 뷰
        self.view.addSubview(csView)
        
        let tabBtnWidth = self.csView.frame.width/3
        let tabBrnheight = self.csView.frame.height
        
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBrnheight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBrnheight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth*2, y: 0, width: tabBtnWidth, height: tabBrnheight)
        
        self.addTapBarBtn(btn: self.tabItem01, title: "첫번째버튼", tag: 0)
        self.addTapBarBtn(btn: self.tabItem02, title: "두번째버튼", tag: 1)
        self.addTapBarBtn(btn: self.tabItem03, title: "세번째버튼", tag: 2)
        
    }
    //탭바버튼 공통속성 정의를 위한 메서드
    func addTapBarBtn(btn : UIButton, title : String, tag : Int){
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .selected) //선택되었을때 색
        btn.addTarget(self, action: #selector(onTabBarIem(_:)), for: .touchUpInside)
        self.csView.addSubview(btn)
    }
    
    @objc func onTabBarIem(_ sender: UIButton){
        //선택되지 않은 것으로 초기화
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        //선택되면 변경
        sender.isSelected = true
       
        selectedIndex = sender.tag
    }
}
