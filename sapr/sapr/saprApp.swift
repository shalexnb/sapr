import SwiftUI

@available(macOS 13.0, *)
@main
struct sapr: App {
    @State var DocView: Bool = true
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
    
}
