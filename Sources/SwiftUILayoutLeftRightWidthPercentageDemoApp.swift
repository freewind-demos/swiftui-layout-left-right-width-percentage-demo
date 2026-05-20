import SwiftUI

@main
struct SwiftUILayoutLeftRightWidthPercentageDemoApp: App {
    var body: some Scene {
        Window("30 / 70 Layout", id: "main") {
            ContentView()
        }
        .defaultSize(width: 900, height: 560)
        .windowResizability(.automatic)
    }
}
