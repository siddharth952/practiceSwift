//
//  RGBBull.swift
//  practiceSwift
//
//  Created by Siddharth sen on 11/25/19.
//  Copyright © 2019 Siddharth sen. All rights reserved.
//

import SwiftUI




struct RGBBull: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess:Double
    @State var bGuess:Double
    @State var showAlert = false
    
    @ObservedObject var timer = TimeCounter()//Declaring data dependency Sub.
    
    
    
    
    func computeScore()->Int{
        
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff*gDiff + bDiff*bDiff)
        
        return Int((1.0 - diff) * 100 + 0.5)
        
    }
    
  
    
    
    
    var body: some View {
        
        
            VStack {
                VStack {
                    
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    //Text(/*@START_MENU_TOKEN@*/"Match the color"/*@END_MENU_TOKEN@*/)
                    
                    self.showAlert ? Text("R:\(Int(rTarget*255))" + ("G:\(Int(gTarget*255))") + ("B:\(Int(bTarget*255))") ) : Text("Match this Color")
                }
                
                
                VStack {
                    
                    ZStack(alignment: .center){
                        
                    Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text(String(timer.counter))
                        .padding(.all,5)
                        .background(Color.white)
                        .mask(Circle())
                        .foregroundColor(.black)
                    
                    }
                    Text("R:\(Int(rGuess*255.0)) G:\(Int(gGuess*255.0)) B:\(Int(bGuess*255.0))")
                    
                    
                    
                    
                }
                VStack{
                ColorSlider(value: $rGuess,difference: abs(rTarget-rGuess), textColor: .red)
                ColorSlider(value: $gGuess,difference: abs(gTarget-gGuess), textColor: .green)
                ColorSlider(value: $bGuess,difference: abs(bTarget-bGuess), textColor: .blue)
                }.padding(.horizontal)
                
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                    
                }) {
                    Text("Hit me")
                }.alert(isPresented: $showAlert){
                    Alert(title: Text("You Score"), message: Text(String(computeScore())))
                }
            }
        }
    
}

struct RGBBull_Previews: PreviewProvider {
    static var previews: some View {
        RGBBull(rGuess: 0.5, gGuess: 0.4, bGuess: 0.5)
    }
}

struct ColorSlider: View {
    
    @Binding var value:Double
    var difference:Double
    var textColor:Color
    
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
                .opacity(difference)
        
            Text("255").foregroundColor(textColor)
            
        }
    }
}
