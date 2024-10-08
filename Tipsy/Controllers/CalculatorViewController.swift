//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var pctButtonSelected: String = "10%"
    var splitNumberSelected: Int = 2
    var tipSelected: Float = 0.1
    var result: Float?
    var resultString: String?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        pctButtonSelected = sender.currentTitle!
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberSelected = Int(sender.value)
        splitNumberLabel.text = String(splitNumberSelected)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if pctButtonSelected == "0%" {
            tipSelected = 0.0
        } else if pctButtonSelected == "20%" {
            tipSelected = 0.2
        } else {
            tipSelected = 0.1
        }
        
        print(tipSelected)
        print("splitNumberSelected: \(splitNumberSelected)")
        print("billTextField: \(billTextField.text ?? "123.45")")
        
        result = (Float(billTextField.text ?? "0") ?? 0.0) * (1 + tipSelected) / Float(splitNumberSelected)
        resultString = String(format: "%.2f", result ?? 0.0)
        print("result: \(resultString!)")
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = resultString
            destinationVC.numberOfPeople = String(splitNumberSelected)
            destinationVC.tipPercentage = pctButtonSelected
        }
    }
    
}

