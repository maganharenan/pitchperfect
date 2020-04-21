//
//  CircleButton.swift
//  PitchPerfect
//
//  Created by Renan Maganha on 19/04/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct CircleButton: View {
    var image:          String
    var firstColor:     UIColor
    var secondColor:    UIColor
    var thirdColor:     UIColor
    
    var body: some View {
       
        Image(image)
            .resizable()
            .frame(width: image == "stop" ? 20 : 40, height: image == "stop" ? 20 : 40)
            .frame(width: 70, height: 70)
            .background(
                ZStack {
                    Color(firstColor)
                    
                    Circle()
                        .foregroundColor(Color(secondColor))
                        .blur(radius: 4)
                        .offset(x: -8, y: -8)
                    
                    Circle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color(thirdColor), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            
                    )
                        .padding(2)
                        .blur(radius: 2)
                }
            )
            .clipShape(Circle())
            .shadow(color: Color(secondColor), radius: 10, x: 10, y: 10)
            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: -5, y: -5)
    }
}
