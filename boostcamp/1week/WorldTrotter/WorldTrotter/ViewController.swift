//
//  ViewController.swift
//  WorldTrotter
//
//  Created by 류진혁 on 2020/08/26.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
@IBOutlet weak var celsiusLabel :UILabel!
    
    var fahrenheitValue : Double?{
          didSet{
              updateCelsiusLabel()
          }
      }
    
   override func viewDidLoad() {
            super.viewDidLoad()
            print("controllerView loaded its view")
    }
    override func viewWillAppear(_ animated: Bool) {
        let view = self.view
        var currentTime = String()
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "ko_Kr")
        currentTime = dateFormatter.string(from: nowDate)
        
        if(Int(currentTime)!<6) || (Int(currentTime)!>18){
            view?.backgroundColor = UIColor.darkGray
        }else{
            view?.backgroundColor = UIColor.cyan
        }
    
    }
    
    var celsiusValue : Double?{
        if let value = fahrenheitValue{
            return (value-32)*(5/9)
        }else{
            return nil
        }
    }
    
    
    @IBOutlet weak var textField : UITextField!
    //배경을 클릭하면 키보드가 내려감
    
    @IBAction func dissmissKeyboard(sender: Any){
                  textField.resignFirstResponder()
              }
    
  
    func updateCelsiusLabel(){
        if let value = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from: value as NSNumber)
        }else{
            celsiusLabel.text = "???"
        }
    }
       
       @IBAction func fahreheitFieldEditingChanged(textField:UITextField){
            if let text = textField.text{
                let value = Double(text)
                   fahrenheitValue = value
               }else{
                   fahrenheitValue = nil
               }
           }
        
    
   //textField 입력 값의 범위를 소수 첫째 자리만 받음
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        
        //알파벳 문자 입력 받지 않게 하기
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let hasAlphabet = string.rangeOfCharacter(from: NSCharacterSet.letters) // 알파벳을 가지고 있으면 거기에 맞는 range 반환.
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || hasAlphabet != nil {
            return false
        }
        else {
            return true
        }
    }
    
    //숫자포맷 지정자로 한자리 소수점 만을 표시
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    


}


