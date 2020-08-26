//
//  ViewController.swift
//  Quiz
//
//  Created by 류진혁 on 2020/08/26.
//  Copyright © 2020 Jin-Hyuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Question: UILabel!
    @IBAction func NextQuestion(_ sender: Any) {
        
        if currentQuestionIndex == questions.count-1{
            currentQuestionIndex = 0
        }else{
            currentQuestionIndex = currentQuestionIndex+1
        }
        
        let question : String = questions[currentQuestionIndex]
        
        Question.text = question
        Answer.text = "???"
        
    }
    @IBOutlet weak var Answer: UILabel!
    
    @IBAction func ShowAnswer(_ sender: Any) {
        Answer.text = answers[currentQuestionIndex]
    }
    
    let questions: [String] = ["From what is cognac made?", "What is 7+7?", "What is the capital of Vermont?"]
    let answers: [String] = ["Grapes", "14", "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Question.text = questions[currentQuestionIndex]
    }


}

