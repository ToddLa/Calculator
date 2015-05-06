//
//  ViewController.swift
//  Calculator
//
//  Created by Todd Laney on 4/23/15.
//  Copyright (c) 2015 Todd Laney. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    private var enteringNumber = false
    private var operandStack : [Double] = []

    @IBAction func appendDot(sender: UIButton)
    {
        println("appendDot: \(sender.currentTitle!)")
        if (!enteringNumber || display.text!.rangeOfString(".") == nil) {
            appendDigit(sender)
        }
    }
    @IBAction func appendDigit(sender: UIButton)
    {
        if let digit = sender.currentTitle {
            println("appendDigit: \(digit)")
            
            if enteringNumber {
                display.text = display.text! + digit
            }
            else {
                display.text = digit
                enteringNumber = true
            }
        }
    }
    
    private func addHistory(str:String)
    {
        history.text = "\(history.text!) \(str)"
    }
    
    @IBAction func clear()
    {
        println("CLEAR")
        enteringNumber = false
        operandStack = []
        displayValue = 0
        history.text = ""
    }
    
    private func performOperation(op:(Double, Double) -> Double)
    {
        if operandStack.count >= 2 {
            displayValue = op(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(op:(Double) -> Double)
    {
        if operandStack.count >= 1 {
            displayValue = op(operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(val:Double)
    {
        displayValue = val
        enter()
    }
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        
        if enteringNumber {
            enter()
        }
        addHistory(operation)
        switch operation {
            case "✖️": performOperation {$0 * $1}
            case "➗": performOperation {$1 / $0}
            case "➕": performOperation {$0 + $1}
            case "➖": performOperation {$0 - $1}
            case "√": performOperation(sqrt)
            case "sin": performOperation(sin)
            case "cos": performOperation(cos)
            case "tan": performOperation(tan)
            case "π": performOperation(M_PI)
            default: break
        }
    }
    
    @IBAction func enter()
    {
        if (enteringNumber) {
            addHistory(display.text!)
        }
        enteringNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    private var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue ?? 0
        }
        set {
            enteringNumber = false
            
            //display.text = "\(newValue)"
            let nf = NSNumberFormatter()
            nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
            nf.maximumFractionDigits = 8
            display.text = nf.stringFromNumber(newValue)
        }
    }
}

