import Cocoa
import SafariServices

class ViewController: NSViewController {
    
    @IBOutlet weak var appNameLabel: NSTextField!
    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var openSafariButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set app name
        if let appNameLabel = appNameLabel {
            appNameLabel.stringValue = "Domain Tracker"
        }
        
        // Check extension status
        updateExtensionStatus()
    }
    
    func updateExtensionStatus() {
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: "com.example.Domain-Tracker.Extension") { (state, error) in
            DispatchQueue.main.async {
                guard let state = state, error == nil else {
                    self.statusLabel?.stringValue = "Error checking extension status"
                    return
                }
                
                if state.isEnabled {
                    self.statusLabel?.stringValue = "✓ Extension is enabled in Safari"
                } else {
                    self.statusLabel?.stringValue = "Extension is not enabled. Please enable it in Safari Preferences."
                }
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.example.Domain-Tracker.Extension") { error in
            if let error = error {
                print("Error opening Safari preferences: \(error.localizedDescription)")
            }
        }
    }
}
