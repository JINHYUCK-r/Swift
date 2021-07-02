//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 류진혁 on 2021/07/01.
//

//MVC패턴에서의 Model 부분
import Foundation


class CalculatorBrain{
    private var accmulator = 0.0
    private var internalProgram = [Any]()
    
    
    func setOperand(operand : Double){
        accmulator = operand
        internalProgram.append(operand)
        
    }
    private var operations : Dictionary<String,Operation> = [
        "∏" : Operation.Constant(M_PI),//M_PI,
        "e" : Operation.Constant(M_E),//M_E
        "±" : Operation.UnaryOperaion({-$0}),
        "√" : Operation.UnaryOperaion(sqrt), //sqrt,
        "cos" : Operation.UnaryOperaion(cos),//cos,
        "×" : Operation.BinaryOperation({ $0 * $1}),
        "÷" : Operation.BinaryOperation({ $0 / $1}),
        "+" : Operation.BinaryOperation({ $0 + $1}),
        "−" : Operation.BinaryOperation({ $0 - $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        //스위프트에서는 함수와 타입과 차이없이 적을수 있음
        //단항연산
        case UnaryOperaion((Double) -> Double)
        //이항연산
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
     func performOperation(symbol : String){
        /*
         switch symbol {
         case "∏":
         accmulator = M_PI
         case "√":
         accmulator = sqrt(accmulator)
         default:
         break
         }
         
         if let constant = operation[symbol]{
         accmulator = constant
         }
         */
        internalProgram.append(symbol)
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accmulator = value
            case .UnaryOperaion(let function):
                accmulator = function(accmulator)
            case .BinaryOperation(let function):
                executePending()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accmulator)
            case .Equals:
                executePending()
            }
        }
        
    }
    private func executePending(){
        if pending != nil{
            accmulator = pending!.binaryFunction(pending!.firstOperand, accmulator)
            pending = nil
        }
    }
    
    private var pending : PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction : (Double, Double) -> Double
        var firstOperand : Double
    }
    //타입을 만들어줌
    typealias PropertyList = AnyObject
    var program : PropertyList{
        get{
            return internalProgram as AnyObject
        }
        set{
            clear()
            if let arryOfOps = newValue as? [Any]{
                for op in arryOfOps{
                    if let operand = op as? Double{
                        setOperand(operand: operand)
                    }else if let operation = op as? String{
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    func clear(){
        accmulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result : Double{
        get{
            return accmulator
        }
    }
}
