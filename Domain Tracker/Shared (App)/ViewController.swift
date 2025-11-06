import Cocoa
import SafariServices

class ViewController: NSViewController {
    
    private var appNameLabel: NSTextField!
    private var statusLabel: NSTextField!
    private var openSafariButton: NSButton!
    private var descriptionLabel: NSTextField!
    
    override func loadView() {
        // Create the main view
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 480, height: 270))
        self.view = view
        
        // App Name Label
        appNameLabel = NSTextField(labelWithString: "Domain Tracker")
        appNameLabel.font = NSFont.boldSystemFont(ofSize: 30)
        appNameLabel.frame = NSRect(x: 136, y: 208, width: 209, height: 37)
        view.addSubview(appNameLabel)
        
        // Status Label
        statusLabel = NSTextField(labelWithString: "Checking extension status...")
        statusLabel.font = NSFont.systemFont(ofSize: 14)
        statusLabel.textColor = NSColor.secondaryLabelColor
        statusLabel.frame = NSRect(x: 68, y: 158, width: 345, height: 32)
        statusLabel.lineBreakMode = .byWordWrapping
        view.addSubview(statusLabel)
        
        // Open Safari Button
        openSafariButton = NSButton(frame: NSRect(x: 130, y: 82, width: 221, height: 32))
        openSafariButton.title = "Open Safari Preferences"
        openSafariButton.bezelStyle = .rounded
        openSafariButton.target = self
        openSafariButton.action = #selector(openSafariExtensionPreferences(_:))
        view.addSubview(openSafariButton)
        
        // Description Label
        descriptionLabel = NSTextField(labelWithString: "Domain Tracker shows all domains that a webpage sends requests to. Click the extension icon in Safari toolbar to see the list.")
        descriptionLabel.font = NSFont.systemFont(ofSize: 12)
        descriptionLabel.textColor = NSColor.secondaryLabelColor
        descriptionLabel.frame = NSRect(x: 48, y: 20, width: 385, height: 48)
        descriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(descriptionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @objc func openSafariExtensionPreferences(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: "com.example.Domain-Tracker.Extension") { error in
            if let error = error {
                print("Error opening Safari preferences: \(error.localizedDescription)")
            }
        }
    }
}
