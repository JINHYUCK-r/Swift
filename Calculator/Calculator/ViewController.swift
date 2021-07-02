//
//  ViewController.swift
//  Calculator
//
//  Created by 류진혁 on 2021/07/01.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet private weak var display: UILabel!
    private var useTyping = false
    

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if useTyping {
            let textDisplay = display.text!
            display.text = textDisplay + digit
        }else{
            display.text = digit
        }
        useTyping = true
    }
    
    private var displayValue : Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOper(_ sender: UIButton) {
        if useTyping {
            brain.setOperand(operand: displayValue)
            useTyping = false
        }
       
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    
    }
    
    var savedProgram : CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
        
    }
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
}

