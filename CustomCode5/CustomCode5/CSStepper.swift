//
//  CSStepper.swift
//  CustomCode5
//
//  Created by 류진혁 on 2021/01/30.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit
@IBDesignable //이 어노테이션이 붙은 클래스가 스토리보드의 객체와 연결되면 에서 미리보기형태로 처리해줌 
//public class CSStepper: UIView { uiview대신 uicontrol을 서브클래싱하면 액션이벤트 연결가능
public class CSStepper: UIControl {
    //var로 선언한 이유는 외부에서 커스터마이징을 할수없기때문
    public var leftBtn =  UIButton(type : .system)
    public var rightBtn = UIButton(type: .system)
    public var centerLabel = UILabel()
    @IBInspectable // 내가 정의한 속성을 인터페이스 빌더의 어트리뷰트 인스펙터 에서도 설정할수있도록 처리해줌
                    // 타입어노테이션이 없으면 사용에 제약이 생김
    public var value : Int = 0{ //stpper의 현재값을 저장할 변수
        didSet{ // value 값이 변경되면 실행되는 구문 
            self.centerLabel.text = String(value)
            //이 클래스를 사용하는 객체들에서 valueChanged 이벤트 신호를 보내준다 
            self.sendActions(for: .valueChanged)
        }
    }
    //왼쪽버튼 타이틀 속성
    @IBInspectable
    public var leftTitle : String = "⬇︎"{
        didSet{
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    //오른쪽버튼 타이틀 속성
    @IBInspectable
    public var rightTitle : String = "⬆︎"{
        didSet{
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    //centerLabel의 색상 변경
    @IBInspectable
    public var bgColor : UIColor = UIColor.cyan{
        didSet{
            self.centerLabel.backgroundColor = backgroundColor
        }
    }

    //스토리보드에서 호출할 초기화 메서드
    public required init?(coder : NSCoder) {
        super.init(coder : coder)
        self.setup()
    }
    //코드 프로그래밍으로 호출할 초기화 메서드
    public override init(frame: CGRect) {
        super.init(frame : frame)
        self.setup()
    }
    //stepper의 기본속성 설정
    private func setup(){
        let borderWidth : CGFloat = 0.5
        let borderColor = UIColor.blue.cgColor
        //왼쪽버튼
        self.leftBtn.tag = -1
        self.leftBtn.setTitle(self.leftTitle, for: .normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.leftBtn.layer.borderWidth = borderWidth
        self.leftBtn.layer.borderColor = borderColor
        self.leftBtn.addTarget(self, action: #selector(valueChage(_:)), for: .touchUpInside)
        
        //오른쪽버튼
        self.rightBtn.tag = 1
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.rightBtn.layer.borderWidth = borderWidth
        self.rightBtn.layer.borderColor = borderColor
        self.rightBtn.addTarget(self, action: #selector(valueChage(_:)), for: .touchUpInside)
        
        //가운데 라벨
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        self.centerLabel.backgroundColor = self.bgColor
        self.centerLabel.layer.borderWidth = borderWidth
        self.centerLabel.layer.borderColor = borderColor
        
        self.addSubview(leftBtn)
        self.addSubview(rightBtn)
        self.addSubview(centerLabel)
        
        
        
    }
    //뷰의 크기를 변경할때 호출되는 메소드
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let btnWidth = self.frame.height
        let lblWidth = self.frame.width-(btnWidth*2)
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth+lblWidth, y: 0, width: btnWidth, height: btnWidth)
    }
    //증감값 단위. 버튼을 한번누를때마다 값을 얼마나 변경할지 정할수 있음
   @IBInspectable
    public var stepValue = 1
    
    //최대값과 최소값설정
    @IBInspectable public var maximumValue : Int = 100
    @IBInspectable public var minimumValue : Int = -100
    
    //버튼을 클릭시 값이 변경
    @objc public func valueChage(_ sender : UIButton){
        //stepper값을 변경하기전에 미리 최대값과 최소값을 벗어나지 않는지 체크
        let sum = self.value + (sender.tag * self.stepValue)
        if(sum>self.maximumValue){
            return
        }
        if(sum<self.minimumValue){
            return
        }
       // self.value += sender.tag
        self.value += (sender.tag * stepValue)
    }
    
}
