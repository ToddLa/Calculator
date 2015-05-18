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
    @IBOutlet weak var status: UILabel!
    
    private var enteringNumber = false
    private var brain = CalculatorBrain()
    private let memoryName = "x"
    
    override func viewDidLoad()
    {
        // make each button a round rect
        for child in view.subviews {
            if let button = child as? UIButton {
                button.layer.cornerRadius = 4.0
            }
        }
        display.adjustsFontSizeToFitWidth = true
        status.adjustsFontSizeToFitWidth = true
        clear()
    }
    
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
                display.textColor = UIColor.blackColor()
            }
            update()
        }
    }
    
    @IBAction func clear()
    {
        println("CLEAR")
        brain.clear()
        enteringNumber = false
        update()
    }
    
    @IBAction func erase() {
        if enteringNumber {
            var num = display.text!
            removeLast(&num)
            display.text = count(num) > 0 ? num : "0"
        } else {
            brain.undo()
        }
        update()
    }
    
    @IBAction func useMemory() {
        if enteringNumber {
            enter()
        }
        brain.pushOperand(memoryName)
        update()
    }

    @IBAction func setMemory() {
        if let x = displayValue {
            brain.setVariable(memoryName, x)
            enteringNumber = false
            update()
        }
    }

    @IBAction func changeSign(sender: UIButton) {
        if enteringNumber {
            display.text = "\(-(displayValue ?? 0))"
        } else {
            operate(sender)
        }
    }
    @IBAction func operate(sender: UIButton)
    {
        if let operation = sender.currentTitle {
            if enteringNumber {
                enter()
            }
            brain.pushOperation(operation)
            update()
        }
     }
    
    @IBAction func enter()
    {
        enteringNumber = false
        if let value = displayValue {
            brain.pushOperand(value)
            update()
        }
    }
    
    private func update()
    {
        if enteringNumber {
            status.text = " " + brain.fullDescription
        } else {
            var str = brain.fullDescription
            if count(str) == 0 {
                status.text = " "
                display.text = "0.0"
                display.textColor = UIColor.blackColor()
            } else {
                status.text = str + "="
                var result = brain.evaluateResult()
                display.text = result.description
                display.textColor = result.value == nil ? UIColor.redColor() : UIColor.blackColor()
            }
        }
    }
    
    private var displayValue: Double? {
        get {
            return NSNumberFormatter().numberFromString(display.text!)?.doubleValue
        }
    }
}

