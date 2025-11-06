import Cocoa
import SafariServices

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create window programmatically
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "Domain Tracker"
        window.makeKeyAndOrderFront(nil)
        
        // Set up view controller
        let viewController = ViewController()
        window.contentViewController = viewController
        
        // Check Safari extension status
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: "com.example.Domain-Tracker.Extension") { (state, error) in
            guard let state = state, error == nil else {
                return
            }
            
            if !state.isEnabled {
                print("Domain Tracker extension is not enabled in Safari")
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
