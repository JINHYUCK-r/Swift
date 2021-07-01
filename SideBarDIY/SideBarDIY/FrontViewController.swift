//
//  FrontViewController.swift
//  SideBarDIY
//
//  Created by 류진혁 on 2021/02/13.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

// 앱이 실행되었을때 사용자에게 보여질 실질적인 화면
import UIKit

class FrontViewController: UIViewController {
    
    var delegate : RevealViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide))
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        //왼쪽모서리에서 화면열기
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide))
        dragLeft.edges = UIRectEdge.left // 사각모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft)
        
        //오른쪽으로 스와이프할때 창 닫기
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide))
        dragRight.direction = .left // 방향은 왼쪽
        self.view.addGestureRecognizer(dragRight)
        
    }
    
    @objc func moveSide (_ sender : Any){
        if sender is UIScreenEdgePanGestureRecognizer{
            self.delegate?.openSideBar(nil)
        }else if sender is UISwipeGestureRecognizer{
            self.delegate?.closeSideBar(nil)
        }else if sender is UIBarButtonItem{
            if self.delegate?.isSideBarShowing == false{
                self.delegate?.openSideBar(nil) // 사이드바를 연다
            }else{
                self.delegate?.closeSideBar(nil) // 사이드바를 닫는다
            }
        }
        
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
