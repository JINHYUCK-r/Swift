//
//  MapAlertViewController.swift
//  CustomCode4
//
//  Created by 류진혁 on 2021/01/28.
//  Copyright © 2021 Jin-Hyuck. All rights reserved.
//

import UIKit
import MapKit

class MapAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    let alertBtn = UIButton(type: .system)
    alertBtn.frame = CGRect(x: 0, y: 150, width: 100, height: 30)
    alertBtn.center.x = self.view.frame.width/2
    alertBtn.setTitle("Map Alert", for: .normal)
    alertBtn.addTarget(self, action: #selector(maptAlert(_:)), for: .touchUpInside)
    self.view.addSubview(alertBtn)
        
    let imageBtn = UIButton(type: .system)
    imageBtn.frame = CGRect(x: 0, y: 200, width: 100, height: 30)
    imageBtn.center.x = self.view.frame.width/2
    imageBtn.setTitle("Image Alert", for: .normal)
    imageBtn.addTarget(self, action: #selector(imagetAlert(_:)), for: .touchUpInside)
    self.view.addSubview(imageBtn)
        
    let slideBtn = UIButton(type: .system)
    slideBtn.frame = CGRect(x: 0, y: 250, width: 100, height: 30)
    slideBtn.center.x = self.view.frame.width/2
    slideBtn.setTitle("Slide Alert", for: .normal)
    slideBtn.addTarget(self, action: #selector(slidetAlert(_:)), for: .touchUpInside)
    self.view.addSubview(slideBtn)
    
    let listBtn = UIButton(type: .system)
    listBtn.frame = CGRect(x: 0, y: 300, width: 100, height: 30)
    listBtn.center.x = self.view.frame.width/2
    listBtn.setTitle("List Alert", for: .normal)
    listBtn.addTarget(self, action: #selector(listAlert(_:)), for: .touchUpInside)
    self.view.addSubview(listBtn)
        
    
    }
    @objc func maptAlert(_ sender : UIButton){
        let alert = UIAlertController(title: nil, message: "여기가 맞습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        //뷰 컨트롤러에 맵키트 추가
        let contentVC = MapkitViewController()
        
        
        alert.setValue(contentVC, forKey: "contentViewController")
        self.present(alert, animated: false)
    }
    
    @objc func imagetAlert(_ sender : Any){
        
        let alert = UIAlertController(title: nil, message: "이번글의 평점은 다음과 같습니다.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        let contentVC = ImageViewController()
        alert.setValue(contentVC, forKey: "ContentViewController")
        self.present(alert, animated: false)
        
    }
    
    @objc func slidetAlert(_ sender : Any){
        let contentVC = ControllerViewController()
         let alert = UIAlertController(title: nil, message: "이번글의 평점을 입력해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            (_) in print(">>>sliderValue = \(contentVC.sliderValue)")
        }
         alert.addAction(okAction)
        alert.setValue(contentVC, forKey: "ContentViewController")
         self.present(alert, animated: false)
    }
    
    @objc func listAlert(_ sender : Any){
        let contentVC = ListViewController()
        //딜리게이트 메소드를 호출받을 대상 설정 
        contentVC.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.setValue(contentVC, forKey: "ContentViewController")
         self.present(alert, animated: false)
    }
    
    func didSelectRowAt(indexPath:IndexPath){
        print(">>>>>>>선택된 행은 \(indexPath.row)입니다.")
    }
    

}
