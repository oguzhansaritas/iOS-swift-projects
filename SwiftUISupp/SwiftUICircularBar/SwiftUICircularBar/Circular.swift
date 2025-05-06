//
//  Circula.swift
//  SwiftUICircularBar
//
//  Created by OGUZHAN SARITAS.
//

import SwiftUI

struct Circular: View {
    let lineWidth : CGFloat
    let backgroundColor:Color
    let foregroundColor:Color
    let percentage:Double
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                CircularShape().stroke(style: StrokeStyle(lineWidth: lineWidth)).fill(backgroundColor)
                
                CircularShape(percent: percentage).stroke(style: StrokeStyle(lineWidth: lineWidth)).fill(foregroundColor)
            }.animation(.easeIn(duration: 1.0), value: percentage)
            .padding(lineWidth/1.5)
        }
        
    }
}

struct Circula_Previews: PreviewProvider {
    static var previews: some View {
        Circular(lineWidth: 10, backgroundColor: .red, foregroundColor: .green, percentage: 50)
    }
}
