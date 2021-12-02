//
//  Key.swift
//  SwiftUI_Calculator (iOS)
//
//  Created by Sanne De Bruin on 12/1/21.
//

import Foundation
import SwiftUI

enum KeyType {
    case Number
    case Operator
}

var operatorSymbols:[String:String] = [
    "+": "plus",
    "-": "minus",
    "*": "multiply",
    "/": "divide",
    "+/-": "plus.slash.minus",
    "%": "percent",
    "=": "equal"
]

struct Key:Identifiable {
    var id: UUID = UUID()
    var label:String
    var color:Color = Color.secondary
    var labelColor:Color = Color.white
    var type:KeyType = KeyType.Number
}

