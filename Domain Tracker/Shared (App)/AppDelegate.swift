import Cocoa
import SafariServices

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Check if Safari extension is enabled
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
