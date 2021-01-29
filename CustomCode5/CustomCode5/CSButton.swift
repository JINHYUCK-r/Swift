//
//  CSButton.swift
//  CustomCode5
//
//  Created by 류진혁 on 2021/01/29.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class CSButton : UIButton{
    
    //스타일 초기값지정
    var style : CSButtonType = .rect{
        //프로퍼티옵저버  : 특정값이 변할때마다 자동으로 호출되는 코드 블록
        //didSet : 값이 변경된 직후 수행. willSet: 값이 변경되기 직전에 수행
        didSet{
            switch style {
            case .rect:
                self.backgroundColor = .black
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.black.cgColor
                self.layer.cornerRadius = 0 //모서리는 둥글지않게
                self.setTitleColor(.white, for: .normal)
                self.setTitle("Rect Button ", for: .normal)
            case .circle:
                self.backgroundColor = .red
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.blue.cgColor
                self.layer.cornerRadius = 50
                self.setTitle("Circle Button ", for: .normal)
            }

            
        }
    }
    
    
     //init(coder:) : 스토리보드 방식으로 객체를 생성할때 호출되는 초기화 메서드
    // NSCoder는 스토리보드에서 자동생성되는 값
    required init(coder aDecoder : NSCoder) {
        super.init(coder : aDecoder)!
        
        //스토리보드 방식으로 버튼을 적용했을때 적용
        self.backgroundColor = .green
        self.layer.borderWidth = 2 //테두리 두께
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle("버튼", for: .normal)
    }
    
    //프로그래밍 방식으로 버튼객체를 생성할때 사용하는 메소드
    override init(frame: CGRect) {
        //1단계 초기화 : 자기자신과 부모의 지정초기화 메서드 호출
        super.init(frame : frame)
        //2단계 초기화 : 초기화가 끝난 프로퍼피를 다시 용도에 맞게 커스텀마이징
        self.backgroundColor = .gray
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.setTitle("코드로 생성된 버튼 ", for: .normal)
    }
    //인자값을 받지않아도됨 
    init(){
        super.init(frame : CGRect.zero)
     //uibutton 클래스는 매개변수가 없는 초기화 메소드의 호출을 허용하지않음
     //부모클래스에서 지정초기화메서드중 하나를 불러온것
    }
    convenience init(type: CSButtonType){
        self.init()
        self.addTarget(self, action: #selector(counting(_:)), for: .touchUpInside)
        switch type {
        case .rect:
            self.backgroundColor = .black
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.cornerRadius = 0 //모서리는 둥글지않게
            self.setTitleColor(.white, for: .normal)
            self.setTitle("Rect Button ", for: .normal)
        case .circle:
            self.backgroundColor = .red
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.blue.cgColor
            self.layer.cornerRadius = 50
            self.setTitle("Circle Button ", for: .normal)
        }
        
        
    }
    
    @objc func counting(_ sender : UIButton){
        sender.tag = sender.tag + 1
        sender.setTitle("\(sender.tag)번째 클릭", for: .normal)
    }
    
    
    
}

public enum CSButtonType{
    case rect
    case circle
}
