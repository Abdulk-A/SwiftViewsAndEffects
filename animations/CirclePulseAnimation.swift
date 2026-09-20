struct CirclePulseAnimation: View {

    @State private var animating: Bool = false
    @State private var duration = 1.5
    
    var body: some View {
        Circle()
            .frame(width: 150, height: 150)
            .foregroundStyle(.red)
            .scaleEffect(animating ? 2.4 : 0.75)
            .opacity(animating ? 0 : 1)
            .animation(.easeInOut(duration: duration).repeatForever(autoreverses: false).delay(duration), value: animating)
            .onAppear {
                animating = true
            }
    }
}