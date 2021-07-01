//
//  RevealViewController.swift
//  SideBarDIY
//
//  Created by 류진혁 on 2021/02/13.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

// 스토리보드의 가장 앞에 위치하여 프론트 뷰와 리어뷰를 컨트롤할 뷰 컨트롤러
// 화면에 나타나지는 않지만 사이드바와 관련된 기능을 처리
// 커스텀 컨테이너 뷰 컨트롤러 : 컨테이너 뷰컨트롤러는 여러개의 뷰 컨트롤러를 포함하고 관리, 분할뷰/페이지뷰...
import UIKit

class RevealViewController: UIViewController {

    var contentVC : UIViewController? // 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC : UIViewController? // 사이드 바 메뉴를 담당할 뷰 컨트롤러
    
    var isSideBarShowing = false // 현재 사이드 바가 열려있는지 여지
    
    let SLIDE_TIME = 0.3 //사이드 바가 열리고 닫히는데 걸리는 시간
    let SIDEBAR_WIDTH : CGFloat = 260 //사이드 바가 열릴 너비
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

    }
    
    //초기화면 설정
    //메소드가 실행될때 자식뷰컨트롤러가 첫화면으로 나오게 됨
    // 마치 프로트컨트롤러가 첫 화면인것처럼 동작하게됨
    func setupView(){
        // _프론트 컨트롤러 객체(스토리보드에서 sw_front로 지정해놓은 컨트롤러)를 읽어온다
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController{
            
            //읽어온 컨트롤러를 클래스 전체에서 참조할수 있도록 contentVC 속성에 저장
            self.contentVC = vc
            
            //_프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록
            self.addChild(vc)   //_프론트 컨트롤러를 메인 컨트롤러의 자식 뷰 컨트롤러로 등록
            
            self.view.addSubview(vc.view) //_프로튼 컨트롤러의 뷰를 메인 컨트롤러의 서브 뷰로 등록
            
            //_프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            
            //프론트컨트롤러의 델리게이트 변수에 참조 정보를 넣어줌
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
        
    }
    
    // 사이드 바의 뷰를 읽어옴
    func getSideView(){
        // 사이드바가 열릴때만 컨트롤러 인스턴스를 생성하기 위해서 nil체크를 함
        guard self.sideVC == nil else{
            return
        }
        //사이드 바 컨트롤러 객체를 읽어온다
        guard let vc = self.storyboard?.instantiateViewController(identifier: "sw_rear") else{
            return
        }
        
        //다른 메소드에서도 참조 할수 있또록 sideVC 속성에 저장
        // contentVC는 항상 뷰 컨트롤러에 객체가 등록되어있어야하지만 sideVC는 사용자가 화면을 열때만 보이면 됨
        // 화면에 보이지않으면서 항상 객체를 유지하고 있으면 메모리가 낭비됨
        self.sideVC = vc
        
        //읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        //_프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다
        vc.didMove(toParent: self)
        
        //_프론트 컨트롤러의 뷰를 제일 위로 올린다.
        self.view.bringSubviewToFront((self.contentVC?.view)!)
    }
    
    // 콘텐츠 뷰에 그림자 효과를 준다
    // shadow : 그림자효과를 적용할지 제거할지에 대한 인자값. offset: 그림자의 깊이감
    func setShadowEffect(shadow:Bool, offset:CGFloat){
        if(shadow == true){ // 그림자 효과 설정
            self.contentVC?.view.layer.masksToBounds = false
            self.contentVC?.view.layer.cornerRadius = 10    //그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8  // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) //그림자 크기
        } else{
            self.contentVC?.view.layer.cornerRadius = 0.0;
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        
    }
    
    //사이드 바를 연다(여는 느낌을 주기위해 )
    // 매개변수 complete : 사이드바가 열린다음이 이어서 실행할 구문을 전달
    //complete 매개변수는 인자값과 반환값이 모두없는 함수나 클로저만 사용가능
    func openSideBar(_ complete: ( () -> Void)?){
        //앞에서 정의한 메소드 실행
        self.getSideView()  //사이드 바 뷰를 읽어옴
        self.setShadowEffect(shadow: true, offset: -2) //그림자 효과를 줌. 높이감 부여
        //애니메이션 옵션
        //curveEaseInOut : 애니메이션 구간별 속도옵션. 처음과끝은 점점느리게 중간은 빠르게.
        //beginFromCurrentState: 현재 다른애니메이션이 진행중이라도 지금 상태에서 실행하도록. 이걸적용하지않으면 진행중인 애니메이션이 끝나고 원하는 애니메이션이 실행됨
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        //애니메이션실행
        UIView.animate( // 비동기 실행
            withDuration: TimeInterval(self.SLIDE_TIME), //애니메이션 실행시간. 값이커지면 천천히 열림
            delay: TimeInterval(0), //애니메이션 실행전에 대기시간. 대부분의 애니메이션 지연시간을 주지않음
            options: options,   //애니메이션 실행옵션
            animations: {   //실행할 애니메이션 내용
                //콘텐츠뷰의 x좌표값을 변경하여 콘텐츠뷰 뒤에 가려져있는 사이드바뷰를 드러나게 함
                self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)},
            completion: {   //애니메이션 완료 후 실행해야 할 내용. 비동기 실행이기 때문에 끝날시점을 특정할수 없기에 애니메이션이 완료후에 호출되도록 completion매개변수 사용
                if $0 == true{  //첫번째 매개변수의 값이 true라면
                self.isSideBarShowing = true    //값을 변경하고
                complete?()     //complete 메소드 호출(openSideBar의 인자값으로 입력된 것 )
            }
        })
    }
    
    //사이드 바를 닫는다
    func closeSideBar(_ complete: ( () -> Void)?){
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations: {
                //x좌표값으로 이동되었던 콘테츠뷰를 원래대로 되돌림
                self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)},
            completion: {
                if $0 == true{
                    //사이드 바 뷰를 제거. 남겨두면 메모리가 낭비됨
                    self.sideVC?.view.removeFromSuperview()
                    self.sideVC = nil
                    //닫힌상태로 값을 변경
                    self.isSideBarShowing = false
                    //그림자 효과 제거
                    self.setShadowEffect(shadow: false, offset: 0)
                    //인자값으로 받은 클로저 실행
                    complete?()
                }
        })
    }
    
}
