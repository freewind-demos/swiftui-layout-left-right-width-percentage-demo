import SwiftUI

struct ContentView: View {
    private let leftRatio: CGFloat = 0.3

    var body: some View {
        GeometryReader { proxy in
            let leftWidth = proxy.size.width * leftRatio
            let rightWidth = proxy.size.width - leftWidth

            HStack(spacing: 0) {
                PercentagePane(
                    title: "30%",
                    background: .blue.opacity(0.8)
                )
                .frame(width: leftWidth)

                PercentagePane(
                    title: "70%",
                    background: .green.opacity(0.8)
                )
                .frame(width: rightWidth)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 480, minHeight: 320)
    }
}

private struct PercentagePane: View {
    let title: String
    let background: Color

    var body: some View {
        ZStack {
            background

            Text(title)
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
