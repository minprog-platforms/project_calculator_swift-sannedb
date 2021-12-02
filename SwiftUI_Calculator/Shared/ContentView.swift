//
//  ContentView.swift
//  Shared
//
//  Created by Sanne De Bruin on 11/30/21.
//

import SwiftUI

struct ContentView: View {
    var calculatorVM:CalculatorVM = CalculatorVM()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ResultView()
                KeyPadView()
            }
        }.environmentObject(calculatorVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
