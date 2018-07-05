//
//  ViewController.swift
//  First App
//
//  Created by Ajith Kumar on 15/06/18.
//  Copyright © 2018 Ajith Kumar. All rights reserved.
//
import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
}

class ViewController: UIViewController {
    
    @IBOutlet weak var labelOutput: UILabel!
    
    @IBOutlet weak var labelCommand: UILabel!
    
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeMode(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeMode(newMode: .multiplication)
    }
    
    @IBAction func didPressDivide(_ sender: Any) {
        changeMode(newMode: .division)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        guard  let labelInt:Double = Double(labelString) else {
            return
        }
        if(currentMode == .not_set || lastButtonWasMode){
            return
        }
        if(currentMode == .addition){
            savedNum +=  labelInt
        }
        else if(currentMode == .subtraction){
            savedNum -=  labelInt
        }
        else if(currentMode == .multiplication){
            savedNum *=  labelInt
        }
        else if(currentMode == .division){
            savedNum /=  labelInt
        }
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0";
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        labelOutput?.text = "0"
        labelCommand?.text = ""
    }
    
   
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if(lastButtonWasMode){
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    
    func updateText(){
        print("\(labelString)")
        guard  let labelInt:Double = Double(labelString) else {
            return
        }
        if(currentMode == .not_set)
        {
            savedNum = labelInt
        }
        
        let numberFormatter:NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let num:NSNumber = NSNumber(value: labelInt)
        
        labelOutput?.text = numberFormatter.string(from: num)
        labelOutput.sizeToFit()
        labelCommand?.text = String(savedNum)
    }
    
    func changeMode(newMode:modes){
        if(savedNum==0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
}

