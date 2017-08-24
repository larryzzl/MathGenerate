//
//  ViewController.swift
//  MathGenerator
//
//  Created by Zunlin Zhang on 19/08/2017.
//  Copyright © 2017 Zunlin Zhang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        generateMath()
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func getRand(min: UInt32, max: UInt32) -> Int {
        let diceFaceCount: UInt32 = (max - min)
        let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1 + Int(min)
        return randomRoll
    }
    
    func generateMath() {
        // add some comment
        let pageCount:Int = 10
        let mathNumber:Int = 100 * pageCount
        
        // get all Plus maths
        var mathPlusLarge10 = Array<String>()
        mathPlusLarge10 = generatePlusLarge10(number: mathNumber)
        
        // get all Minus maths
        var mathMinusLarge10 = Array<String>()
        mathMinusLarge10 = generateMinusLarge10(number: mathNumber)
        
        // Randamly pick Plua or Minus
        var finalMath = Array<String>()
        for i in 0 ..< mathNumber {
            var mathElement: String = ""
            if (getRand(min: 1, max: 10) > 5)
            {
                mathElement = mathPlusLarge10[i]
            }
            else
            {
                mathElement = mathMinusLarge10[i]
            }
            
            finalMath.append(mathElement)
            //NSLog(mathElement)
        }
        
        // Make it 2 columns for print
        var finalMathFor2 = Array<String>()
        var i = 0
        while (i < mathNumber)
        {
            var mathElementFor2: String = finalMath[i]
            
            if (i < mathNumber - 1) {
                mathElementFor2 = mathElementFor2 + "\t\t" + finalMath[i + 1]
            }
            i = i + 2
            
            finalMathFor2.append(mathElementFor2)
            NSLog(mathElementFor2)
        }
        
        // Write to file
        let file = "data.txt"
        let joined = finalMathFor2.joined(separator: "\n")
        
        if let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            //writing
            do {
                try joined.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                NSLog("Write File Error!!!")
            }
        }
        
    }
    
    func generatePlusLarge10(number: Int) -> Array<String> {
        var plusLarge10 = Array<String>()
        
        var preA = 0
        var preB = 0
        
        for i in 0 ..< number {
            var A = getRand(min: 2, max: 9)
            var B = getRand(min: (11 - UInt32(A)), max: 10)
            
            while (preA == A && preB == B) {
                A = getRand(min: 2, max: 9)
                B = getRand(min: (11 - UInt32(A)), max: 10)
            }
            
            plusLarge10.append(String(A) + " + " + String(B) + " = ")
            preA = A
            preB = B
            
            //NSLog(String(plusLarge10[i]))
        }

        return plusLarge10
    }

    func generateMinusLarge10(number: Int) -> Array<String> {
        var minusLarge10 = Array<String>()
        
        var preA = 0
        var preB = 0
        
        for i in 0 ..< number {
            var B = getRand(min: 1, max: 9)
            var A = getRand(min: 1, max: (UInt32(B) - 1)) + 10
            
            while (preA == A && preB == B) {
                B = getRand(min: 1, max: 9)
                A = getRand(min: 1, max: (UInt32(B) - 1)) + 10
            }
            
            minusLarge10.append(String(A) + " - " + String(B) + " = ")
            preA = A
            preB = B
            
            //NSLog(String(minusLarge10[i]))
        }
        
        return minusLarge10
    }

}

