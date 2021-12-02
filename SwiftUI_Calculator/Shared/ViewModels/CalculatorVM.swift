//
//  CalculatorVM.swift
//  SwiftUI_Calculator (iOS)
//
//  Created by Sanne De Bruin on 12/2/21.
//

import SwiftUI

class CalculatorVM: ObservableObject {
    @Published var result:String = "0"
    @Published var fontSize = 90
    
    var numberFormatter:NumberFormatter = NumberFormatter()
    var unformattedNumberValue:String = "0"
    
    var activeOperation:String = ""
    var previousValue:Double = 0
    
    init() {
        self.numberFormatter.usesGroupingSeparator = true
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.locale = Locale.current
    }
    
    func getFontSize() {
        switch self.unformattedNumberValue.count {
        case 7:
            self.fontSize = 80
        case 8:
            self.fontSize = 70
        case 9:
            self.fontSize = 60
        default:
            self.fontSize = 90
        }
    }
    
    func handleKeyPress(key: Key) {
        if key.type == KeyType.Operator {
            self.handleOperationSelection(label: key.label)
        } else {
            switch key.label {
            case "AC":
                self.reset()
            case "C":
                self.cancel()
            default:
                self.handleNumberSelection(label: key.label)
            }
        }
        
    }
    
    func handleOperationSelection(label: String) {
        var calculatedValue:Double = 0
        let currentNumber:Double = Double(unformattedNumberValue) ?? 0
        
        if (activeOperation != "") {
            switch activeOperation {
            case "+":
                calculatedValue = previousValue + currentNumber
            case "-":
                calculatedValue = previousValue - currentNumber
            case "*":
                calculatedValue = previousValue * currentNumber
            case "/":
                calculatedValue = previousValue > 0 ? previousValue / currentNumber : 0
            default:
                calculatedValue = previousValue
            }
            
            previousValue = calculatedValue
            result = formatNumber(value: String(calculatedValue))
        } else {
            activeOperation = label
            previousValue = previousValue > 0 ? previousValue : currentNumber
        }
        
        activeOperation = label != "=" && label != "%" && label != "+/-"
            ? label : ""
        unformattedNumberValue = "0"
    }
    
    func handleNumberSelection(label: String) {
        if (self.unformattedNumberValue.count == 0 || self.unformattedNumberValue.count < 9) {
            self.unformattedNumberValue = self.unformattedNumberValue == "0"
                ? label : self.unformattedNumberValue + label
            
            self.result = self.formatNumber(value: self.unformattedNumberValue)
            self.getFontSize()
        }
    }
    
    func cancel() {
        self.unformattedNumberValue = "0"
        self.result = "0"
    }
    
    func reset() {
        self.cancel()
        self.activeOperation = ""
        self.previousValue = 0
    }
    
    func formatNumber(value:String) -> String {
        var formattedValue = value
        
        if let doubleValue = Double(formattedValue) {
            formattedValue = self.numberFormatter.string(from: NSNumber(value: doubleValue)) ?? value
        }
        
        return formattedValue
    }
    
    func getKeys() -> [[Key]] {
        let cancel = self.result == "0" ? "AC" : "C";
        
        return [
            [
                Key(label: cancel, color: Color.gray, labelColor: Color.black),
                Key(label: "+/-", color: Color.gray, labelColor: Color.black, type: KeyType.Operator),
                Key(label: "%", color: Color.gray, labelColor: Color.black, type: KeyType.Operator),
                Key(label: "/", color: Color.orange, labelColor: Color.white, type: KeyType.Operator),
            ],
            [
                Key(label: "7"),
                Key(label: "8"),
                Key(label: "9"),
                Key(label: "*", color: Color.orange, labelColor: Color.white, type: KeyType.Operator),
            ],
            [
                Key(label: "4"),
                Key(label: "5"),
                Key(label: "6"),
                Key(label: "-", color: Color.orange, labelColor: Color.white, type: KeyType.Operator),
            ],
            [
                Key(label: "1"),
                Key(label: "2"),
                Key(label: "3"),
                Key(label: "+", color: Color.orange, labelColor: Color.white, type: KeyType.Operator),
            ],
            [
                Key(label: "0"),
                Key(label: "."),
                Key(label: "=", color: Color.orange, labelColor: Color.white, type: KeyType.Operator),
            ],
        ]
    }
}
