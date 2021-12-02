//
//  ResultView.swift
//  SwiftUI_Calculator (iOS)
//
//  Created by Sanne De Bruin on 12/1/21.
//

import SwiftUI

struct ResultView:View {
    @EnvironmentObject var calculatorVM:CalculatorVM
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(calculatorVM.result)
                    .foregroundColor(Color.white)
                    .font(.system(size: CGFloat(calculatorVM.fontSize)))
                    .padding(.trailing, 30)
            }
        }
    }
}
