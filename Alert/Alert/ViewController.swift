//
//  ViewController.swift
//  Alert
//
//  Created by 류진혁 on 2020/09/11.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //UIAlertController.Style 은 alert 랑 actionSheet 두가지 형태가 있음
    
    //팝업으로 뜨는거
    @IBAction func touchUpShowAlertButton (_ sender : UIButton){
        self.showAlertController(style: UIAlertController.Style.alert)
    }
    
    // 액션 시트트는 알림창이 밑에서올라오는거
    @IBAction func touchUpShowActionSheetButton(_ sender : UIButton){
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
    
    @IBOutlet weak var myLabel : UILabel!
    
    
    
    func showAlertController (style : UIAlertController.Style){
        
        let alertController : UIAlertController
        alertController = UIAlertController(title: "title", message: "Message", preferredStyle: style)
        
        //alert의
        //ok버튼
        let okAction : UIAlertAction
        okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action : UIAlertAction) in
            print("OK pressed")
            //handler는 사용자가 ok버튼을 눌렀을때 실행될 코드블럭
            
            //alert로 입력받은 텍스트를 불러오기
            self.myLabel.text = alertController.textFields?[0].text
            
        })
        //cancel 버튼
        let cancelAction : UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        //액션을 alert 컨트롤러에 추가해 주어야함
             alertController.addAction(okAction)
             alertController.addAction(cancelAction)
        
        //handeler 를 코드 밖에 놔두고 상수를 사용하면 반복사용시 편리
        //액션에 대한 응답을 처리할수있음
        let handler : (UIAlertAction) -> Void
        handler = { (action : UIAlertAction) in print("action pressed \(action.title ?? "")")
            
        }
        
        //destructive 스타일은 빨간색으로 나타남. 주의해야하는 버튼을 나타날때 사용
        let someAction : UIAlertAction
        someAction = UIAlertAction(title: "Some", style: UIAlertAction.Style.destructive, handler: handler)
        
        // UIAlertAction.Style.cancel, cancel 스타일은 단 하나만 존재할수 있음. 여러개를 만드려고 하면 오류
       /*
        let anotherAction: UIAlertAction
        anotherAction = UIAlertAction(title: "Another", style: UIAlertAction.Style.cancel, handler: handler)
         */
        
        let anotherAction: UIAlertAction
        anotherAction = UIAlertAction(title: "Another", style: UIAlertAction.Style.default, handler: handler)
        
        //alert에 텍스트를 입력받기 위한 공간이 나타남
        // 액션시트에는 사용불가
        alertController.addTextField { (field : UITextField) in
            field.placeholder = "플레이스홀더"
            field.textColor = UIColor.red
        }
        
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
     
        
        //화면에 보여줌. 모달을 올려줌
        self.present(alertController, animated: true, completion: {
            print("Alert controller shown")
            //completion은 모달이 호출되고 난 직후에 불려옴
        })
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

