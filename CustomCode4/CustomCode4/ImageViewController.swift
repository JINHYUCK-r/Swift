//
//  ImageViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    let icon = UIImage(named: "rating5")
    let iconV = UIImageView(image: icon)
        
        iconV.frame = CGRect(x: 0, y: 0, width: (icon?.size.width)!, height: (icon?.size.height)!)
        
        
        self.view.addSubview(iconV)
        //외부객체가 이 컨트롤러를 표현할때 나타내는 사이즈 
        self.preferredContentSize = CGSize( width: (icon?.size.width)!, height: (icon?.size.height)!+10)
        
    }
    


}
