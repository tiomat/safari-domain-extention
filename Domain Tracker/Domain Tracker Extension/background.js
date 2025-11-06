// Store domains per tab
const tabDomains = new Map();

// Listen for web requests
browser.webRequest.onBeforeRequest.addListener(
  (details) => {
    const tabId = details.tabId;
    
    // Ignore requests that don't belong to a tab
    if (tabId === -1) {
      return;
    }
    
    try {
      const url = new URL(details.url);
      const domain = url.hostname;
      
      // Initialize tab domains if not exists
      if (!tabDomains.has(tabId)) {
        tabDomains.set(tabId, new Set());
      }
      
      // Add domain to the set for this tab
      tabDomains.get(tabId).add(domain);
    } catch (e) {
      console.error('Error parsing URL:', e);
    }
  },
  { urls: ["<all_urls>"] }
);

// Clean up when tab is closed
browser.tabs.onRemoved.addListener((tabId) => {
  tabDomains.delete(tabId);
});

// Clean up when tab is replaced (e.g., prerendering)
browser.tabs.onReplaced.addListener((addedTabId, removedTabId) => {
  tabDomains.delete(removedTabId);
});

// Handle messages from popup
browser.runtime.onMessage.addListener((message, sender, sendResponse) => {
  if (message.action === 'getDomains') {
    const tabId = message.tabId;
    const domains = tabDomains.has(tabId) 
      ? Array.from(tabDomains.get(tabId)).sort()
      : [];
    sendResponse({ domains });
  } else if (message.action === 'clearDomains') {
    const tabId = message.tabId;
    if (tabDomains.has(tabId)) {
      tabDomains.get(tabId).clear();
    }
    sendResponse({ success: true });
  }
  return true; // Keep channel open for async response
});
