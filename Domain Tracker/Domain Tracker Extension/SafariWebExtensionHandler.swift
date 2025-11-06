import SafariServices

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        guard let item = context.inputItems.first as? NSExtensionItem else {
            NSLog("No input items in extension context")
            context.completeRequest(returningItems: [], completionHandler: nil)
            return
        }
        
        let message = item.userInfo?[SFExtensionMessageKey]
        if let message = message {
            NSLog("Received message from browser.runtime.sendNativeMessage: %@", String(describing: message))
        }
        
        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ?? "no message" ] ]
        
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
}
