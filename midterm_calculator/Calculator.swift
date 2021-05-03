//
//  Calculator.swift
//  midterm_calculator
//
//  Created by  iLab on 2021/5/2.
//

import Foundation
class Calculator{
    private var state = "start" // equalFlag
//    private var expressionTokenList = Array<String>()
    private var answerText = "0"
    private var inputToken:String = "0"
    private var inputTokenState = "empty" //numberWithoutPoint, numberWithPoint, doubleNumber, empty
    private var operatorState = "none" //"+", "-", "x", "/"
    private var inputTokenList = Array<String>()
    
    // infix to postfix
    private var operatorStack = Array<String>()
    private var postfixList = Array<String>()
    
    //postfix to answer
    private var answerStack = Array<Double>()
    
    func touchNumber(number:Int){
        operatorState = "none"
        if (inputTokenState == "empty"){
            inputTokenState = "numberWithoutPoint"
        }
        else if (inputTokenState == "numberWithPoint"){
            inputTokenState = "doubleNumber"
        }
//        if (inputToken == "0"){
//            inputToken = String(number)
//        }
//        else if (inputTokenState == "doubleNumber"){
//            if (number != 0){
//                inputToken.append(String(number))
//            }
//        }
        else{
            inputToken.append(String(number))
        }
        
    }
    
    func touchOperator(operatorSymbol:String){
        if (operatorState != "none"){
            
            inputTokenList[inputTokenList.endIndex-1] = operatorSymbol
//            expressionTokenList[expressionTokenList.endIndex-1] = operatorSymbol
//            print(inputTokenList[inputTokenList.endIndex-1])
            operatorState = operatorSymbol
        }
        else{
            if (inputTokenState == "empty"){
    //            inputToken = ""
                inputTokenList.append("0")
    //            expressionTokenList.append("0")
            }
            else if (inputTokenState == "doubleNumber"){
                let inputTokenDouble = Double(inputToken)
                let inputTokenInt = Int(inputTokenDouble!)
                if (inputTokenDouble! - Double(inputTokenInt) == 0){
                    inputTokenList.append(String(inputTokenInt))
                }
                else{
                    inputTokenList.append(String(inputTokenDouble!))
                }
    //            expressionTokenList.append(inputToken)
            }
            else if (inputTokenState == "numberWithoutPoint"){
                let inputTokenInt = Int(inputToken)
                inputTokenList.append(String(inputTokenInt!))
            }
            inputTokenList.append(operatorSymbol)
    //        expressionTokenList.append(operatorSymbol)
            operatorState = operatorSymbol
            inputToken = ""
            inputTokenState = "empty"
        }
    }
    func touchPoint(){
        operatorState = "none"
        if (inputTokenState == "empty"){
            inputTokenState = "numberWithPoint"
            inputToken = "0."
        }
        else if (inputTokenState == "numberWithoutPoint"){
            inputTokenState = "numberWithPoint"
            inputToken.append(".")
        }
    }
    
    func touchEqual(){
        if (state != "equal"){
            
            // infix to postfix
            let operatorOrder: [String: Int] = ["+": 1, "-": 1, "x": 2, "/": 2]
            touchOperator(operatorSymbol: "+")
            inputTokenList.removeLast()
            for infixToken in inputTokenList{
                if (infixToken != "+" && infixToken != "-" && infixToken != "x" && infixToken != "/"){
                    postfixList.append(infixToken)
                }
                else{
                    if (operatorStack.isEmpty != true){
                        if (operatorOrder[operatorStack.last!]! >= operatorOrder[infixToken] ?? 0){
                            let lastOperator = operatorStack.removeLast()
                            postfixList.append(lastOperator)
                        }
                    }
                    operatorStack.append(infixToken)
                }
            }
            
            while (operatorStack.isEmpty != true){
                let lastOperator = operatorStack.removeLast()
                postfixList.append(lastOperator)
            }
            print (postfixList)
            
            // postfix to answer
            for postfixToken in postfixList{
                var answer:Double = 0
                if (postfixToken != "+" && postfixToken != "-" && postfixToken != "x" && postfixToken != "/"){
                    let doubleNumber = Double(postfixToken)
                    answerStack.append(doubleNumber!)
                }
                else{
                    let numberB = answerStack.removeLast()
                    let numberA = answerStack.removeLast()
                    print ("numberB = \(numberB)")
                    print ("numberA = \(numberA)")
                    
                    if (postfixToken == "+"){
                        answer = numberA + numberB
                    }
                    else if (postfixToken == "-"){
                        answer = numberA - numberB
                    }
                    else if (postfixToken == "x"){
                        answer = numberA * numberB
                    }
                    else if (postfixToken == "/"){
                        if (numberB == 0){
                            answer = 0
                        }
                        else{
                            answer = numberA / numberB
                        }
                    }
                    answerStack.append(answer)
                }
            print(answerStack)
            }
            let answerDouble = Double(answerStack[0])
            let answerInt = Double(Int(answerStack[0]))
            if ((answerDouble - answerInt > 0 && answerDouble > 0) || (answerDouble - answerInt < 0 && answerDouble < 0)){
                inputToken = String(format: "%.6f", Double(answerStack[0]))
                let doubleNumber = Double(inputToken)
                inputToken = String(doubleNumber!)
                
            }
            else{
                inputToken = String(Int(answerStack[0]))
            }
        }
        state = "equal"
    }
    
    func touchPercent(){
        let percentDouble = Double(inputToken)!/100
        
        inputToken = String(percentDouble)
        let inputTokenDouble = Double(inputToken)
        let inputTokenInt = Int(inputTokenDouble!)
        if (inputTokenDouble! - Double(inputTokenInt) == 0){
            inputTokenState = "numberWithoutPoint"
            inputToken = String(inputTokenInt)
        }
        else{
            inputTokenState = "doubleNumber"
        }
    }
    
    func touchSign(){
        if (inputTokenState == "doubleNumber"){
            let percentDouble = Double(inputToken)!*(-1)
            inputToken = String(percentDouble)
        }
        else{
            let percentDouble = Int(inputToken)!*(-1)
            inputToken = String(percentDouble)
        }
        
    }
    
    func reset(){
        answerText = "0"
        state = "start"
        inputToken = ""
        inputTokenState = "empty"
        operatorState = "none"
//        expressionTokenList.removeAll()
        inputTokenList.removeAll()
        operatorStack.removeAll()
        postfixList.removeAll()
        answerStack.removeAll()
    }
    func getAnswer() -> String{
        
        return inputToken
    }
    
    func getExpression() -> String{
        var expressionText = ""
        for expressionToken in inputTokenList{
            expressionText.append(expressionToken)
            expressionText.append(" ")
        }
        if (expressionText != ""){
            expressionText.removeLast()
        }
        return expressionText
    }
    
    init(){
        
    }
}
