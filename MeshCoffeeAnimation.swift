//
//  MeshCoffeeAnimation.swift
//  AnimationPractice
//
//  Created by Abdullah on 9/6/26.
//

import SwiftUI

struct MeshCoffeeAnimation: View {
    var body: some View {
        ZStack {
            
            Color(red: 40/255, green: 42/255, blue: 77/255)
                .ignoresSafeArea()
            
            //just using geometry here for positioning
            GeometryReader { geometry in
                VStack {
                    SmokeView()
                        .offset(x: -15)
                    CupView()
                        
                }
                .position(x: geometry.size.width / 1.85, y: geometry.size.height / 2.35)
            }
        }
    }
}



struct SmokeView: View {
    //rgb(236, 235, 242)
    let smokeColor = Color(red: 236/255, green: 235/255, blue: 242/255)
    
    let offsets: [CGFloat] = [0, 12, -6, -24, 0, 24, 12]
    let numRects: [Int] = [1, 1, 2, 1, 3, 1, 1]
    
    
    @State private var currOpacity = 0.0
    
    @State private var k = 0
    @State private var l = 0
    

    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(offsets.indices, id: \.self) { i in
                HStack(spacing: 0) {
                    ForEach(0..<numRects[i], id: \.self) { j in
                        Rectangle()
                            .frame(width: 12, height: 12)
                            .opacity(i < k || (i == k && reversedIndex(i, j) < l) ? 1 : 0)
                    }
                    
  
                }
                
                .offset(x: offsets[i])
            }
        }
        .foregroundStyle(smokeColor)
        .scaleEffect(y: -1)
        .onAppear {
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                withAnimation(.easeOut) {
                    if k == offsets.count {
                        
                        k = 0
                        l = 0
                        return
                    }
                    
                    l += 1
                    if l == numRects[k] {
                        l = 0
                        k += 1
                    }
                }
            }
 
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func reversedIndex(_ i: Int, _ j: Int) -> Int {
        let reversedRows: Set<Int> = [2]
        return reversedRows.contains(i) ? (numRects[i] - 1 - j) : j
    }
}

struct CupView: View {
    
    //rgb(245, 217, 125)
    let lightYellow = Color(red: 245/255, green: 217/255, blue: 125/255)
    
    //rgb(230, 198, 96)
    let darkYellow = Color(red: 230/255, green: 198/255, blue: 96/255)
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ZStack(alignment: .trailing) {
                    UnevenRoundedRectangle(topLeadingRadius: 8, bottomLeadingRadius: 20, bottomTrailingRadius: 20, topTrailingRadius: 8)
                        .foregroundStyle(lightYellow)
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 20, topTrailingRadius: 8)
                        .foregroundStyle(darkYellow)
                        .frame(width: 35)
                }
                .frame(width: 90, height: 120)
                
                UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 26, topTrailingRadius: 8)
                    .stroke(lineWidth: 14)
                    .foregroundStyle(darkYellow)
                    .frame(width: 30, height: 70)
                    .padding(.bottom, 10)
            }
        }
        
    }
}
