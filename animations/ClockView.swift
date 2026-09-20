//
//  ClockView.swift
//  Fun
//
//  Created by Abdullah on 11/28/25.
//

import SwiftUI

struct ClockView: View {
    @State private var secondHand = 0

    var trimLength: CGFloat {
        return CGFloat(secondHand) / 60
    }

    var secondDegree: CGFloat {
        (360 * trimLength)
    }
    var minuteDegree: CGFloat {
        secondDegree / 60
    }

    var hourDegree: CGFloat {
        minuteDegree / 12
    }
    
    let width = UIScreen.main.bounds.width
    var radius: CGFloat {
        (width * 0.75) / 2
    }
    
    let clockValues = [3,4,5,6,7,8,9,10,11,12,1,2]

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {

                ForEach(Array(clockValues.enumerated()), id: \.offset) { index, val in
                    Text("\(val)")
                        .offset(x: radius * cos((30 * CGFloat(index)) * .pi / 180), y: radius * sin((30 * CGFloat(index)) * .pi / 180))
                }
                
                
                Rectangle()
                    .clockMode(width: width, length: 0.9, radius: radius, degree: secondDegree, color: .red)
                
                Rectangle()
                    .clockMode(width: width, length: 0.75, radius: radius, degree: minuteDegree, color: .black)
                
                Rectangle()
                    .clockMode(width: width, length: 0.6, radius: radius, degree: hourDegree, color: .black)
            }
        }
        .onReceive(timer) { _ in
            //you can set to run for as long as you want or just reset it
            if secondHand < 86400 {
                secondHand += 1
            }
            else {
                secondHand = 0
            }
        }
    }
}


struct ClockHandModifier: ViewModifier {
    var width: CGFloat
    var length: CGFloat
    var radius: CGFloat
    var degree: CGFloat
    var color: Color
    
    var calcLength: CGFloat {
        radius * length
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: width * 0.01, height: calcLength)
            .offset(y: -(calcLength) / 2)
            .rotationEffect(.degrees(degree))
            .foregroundStyle(color)
            .animation(.easeInOut, value: degree)
    }
}

extension View {
    func clockMode(width: CGFloat, length: CGFloat, radius: CGFloat, degree: CGFloat, color: Color) -> some View {
        self.modifier(ClockHandModifier(width: width, length: length, radius: radius, degree: degree, color: color))
    }
}

#Preview {
    ClockView()
}

