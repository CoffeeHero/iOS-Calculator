//
//  ViewController.swift
//  midterm_calculator
//
//  Created by  iLab on 2021/5/2.
//

import UIKit

class ViewController: UIViewController {
    lazy var calculator:Calculator = Calculator()
    @IBOutlet weak var expression: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBAction func touchOperatorButton(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            calculator.touchOperator(operatorSymbol: "+")
        case 1:
            calculator.touchOperator(operatorSymbol: "-")
        case 2:
            calculator.touchOperator(operatorSymbol: "x")
        case 3:
            calculator.touchOperator(operatorSymbol: "/")
        default:
            print("Error: Button doesn't have valid tag")
        }
        updateLabelFromModel()
    }
    
    @IBAction func touchPointButton(_ sender: UIButton) {
        calculator.touchPoint()
        updateLabelFromModel()
    }
    
    @IBAction func touchNumberButton(_ sender: UIButton) {
        calculator.touchNumber(number: sender.tag)
        updateLabelFromModel()
    }
    
    @IBAction func touchEqualButton(_ sender: UIButton) {
        calculator.touchEqual()
        updateLabelFromModel()
    }
    
    @IBAction func touchPercentButton(_ sender: UIButton) {
        calculator.touchPercent()
        updateLabelFromModel()
    }
    
    @IBAction func touchSignButton(_ sender: UIButton) {
        calculator.touchSign()
        updateLabelFromModel()
    }
    
    @IBAction func touchACButton(_ sender: UIButton) {
        calculator.reset()
        updateLabelFromModel()
    }
    
    func updateLabelFromModel(){
        expression.text = calculator.getExpression()
        answer.text = calculator.getAnswer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

