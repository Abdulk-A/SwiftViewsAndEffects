//
//  ConfettiAnimation2.swift
//  AnimationPractice
//
//  Created by Abdullah on 10/4/26.
//

import SwiftUI

struct ConfettiAnimation2: View {

    @State private var isActive = false

    let confetti = Confetti()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                GeometryReader { proxy in
                    ConfettiAnimationViewPractice(animating: isActive, size: proxy.size)
                }

                Spacer()
                Button {
                    withAnimation {
                        isActive.toggle()
                    }
                } label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.white)
                        Text("Activate")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                .frame(width: 140, height: 50)
            }
        }
    }
}

struct Confetti: Identifiable {
    let id = UUID()
    let Color: Color = [.red, .orange, .green, .blue, .yellow, .pink].randomElement()!
    let width: CGFloat = .random(in: 6...11)
    let height: CGFloat = .random(in: 10...18)

    let color: Color = [.red, .green, .blue, .yellow, .pink, .purple, .orange, .cyan].randomElement()!
    let startXFraction: Double = .random(in: 0.3...0.7)
    let horizontalDrift: CGFloat = .random(in: -140...140)

    let spin: Double = .random(in: 2...6)
    let duration: Double = .random(in: 1.5...2.5)
    let delay: Double = .random(in: 0...0.25)
    let launchHeight: CGFloat = .random(in: 120...260)

}

struct ConfettiAnimationViewPractice: View {

    let animating: Bool
    let size: CGSize

    //Creates 100 unique pieces
    @State private var pieces = (0..<100).map {_ in Confetti()}

    var body: some View {
        ForEach(pieces) { piece in
            RoundedRectangle(cornerRadius: 3)
                .rotation3DEffect(
                    .degrees(animating ? piece.spin * 360 : 0),
                    axis: (x: 1, y: 0.4, z: 0.2)
                )
                .foregroundStyle(piece.Color)
                .frame(width: piece.width, height: piece.height)
                .position(
                    x:size.width * CGFloat(piece.startXFraction) + (animating ? piece.horizontalDrift : 0),
                    y: animating ? size.height + 30 : (size.height / 2) - piece.launchHeight
                )
                .opacity(animating ? 0 : 1)
                .animation(
                    .easeIn(duration: piece.duration).delay(piece.delay), value: animating
                )

        }
    }
}