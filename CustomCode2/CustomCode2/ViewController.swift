//
//  ViewController.swift
//  CustomCode2
//
//  Created by 류진혁 on 2021/01/21.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "첫번째 탭"
        title.textColor = .red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit() //먼저 설정하고 가운데 맞추는게 좋다
        title.center.x = self.view.frame.width/2
        self.view.addSubview(title)
         /* 여기서 탭바를 설정하면 이 뷰가 불러와질때 설정됨
        self.tabBarItem.image = UIImage(named: "calendar.png")
        self.tabBarItem.title = "Calendar"
        */
          
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
       // tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        UIView.animate(withDuration: TimeInterval(0.15)){
            //alpha 값이 0이면 1로, 1이면 0으로 바꾸어준다
            //호출될때마다 점점 투명해졌다가 점점 진해질것
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }
    }

}

