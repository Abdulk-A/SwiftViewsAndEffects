//
//  ScrollBlurView.swift
//  Fun
//
//  Created by Abdullah on 11/27/25.
//

import SwiftUI

struct ScrollBlurView: View {
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Text("Top Bar Stuff")
                    .font(.largeTitle)
                    .bold()
            }
            .zIndex(1)
            
            ScrollView {
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 50)
                
                ForEach(0..<30, id: \.self) { _ in
                    Text("Hello World")
                        .padding(10)
                        .scrollBlur()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct ScrollBlurModifier: ViewModifier {
    
    @State private var yPosition: CGFloat = 0
    

    let thresholds: (CGFloat, CGFloat, CGFloat)
    

    var blurAmount: CGFloat {
        if yPosition < thresholds.0 { return 6 } //these values can be edieted to match your blur preference
        if yPosition < thresholds.1 { return 7 }
        if yPosition < thresholds.2 { return 8 }
        return 0
    }
    
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            yPosition = proxy.frame(in: .global).minY
                        }
                        .onChange(of: proxy.frame(in: .global).minY) { newY, _ in
                            yPosition = newY
                        }
                }
            )
            .blur(radius: blurAmount)
    }
}

extension View {
    func scrollBlur(threshHold: (CGFloat, CGFloat, CGFloat) = (30, 50, 70)) -> some View {
        return self.modifier(ScrollBlurModifier(thresholds: threshHold))
    }
}

#Preview {
    ScrollBlurView()
}

