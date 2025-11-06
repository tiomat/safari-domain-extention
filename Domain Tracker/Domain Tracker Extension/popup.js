// Get current tab and fetch domains
async function loadDomains() {
  try {
    // Get current tab
    const tabs = await browser.tabs.query({ active: true, currentWindow: true });
    
    if (tabs.length === 0) {
      showNoDomains();
      return;
    }
    
    const tabId = tabs[0].id;
    
    // Request domains from background script
    const response = await browser.runtime.sendMessage({
      action: 'getDomains',
      tabId: tabId
    });
    
    displayDomains(response.domains);
  } catch (error) {
    console.error('Error loading domains:', error);
    showNoDomains();
  }
}

// Display domains in the popup
function displayDomains(domains) {
  const loadingEl = document.getElementById('loading');
  const noDomainsEl = document.getElementById('noDomains');
  const domainListEl = document.getElementById('domainList');
  const countEl = document.getElementById('count');
  
  loadingEl.style.display = 'none';
  
  if (domains.length === 0) {
    noDomainsEl.style.display = 'block';
    domainListEl.style.display = 'none';
    countEl.textContent = 'No domains tracked';
  } else {
    noDomainsEl.style.display = 'none';
    domainListEl.style.display = 'flex';
    
    // Clear previous content
    domainListEl.innerHTML = '';
    
    // Add each domain
    domains.forEach(domain => {
      const domainItem = document.createElement('div');
      domainItem.className = 'domain-item';
      domainItem.textContent = domain;
      domainListEl.appendChild(domainItem);
    });
    
    // Update count
    const count = domains.length;
    countEl.textContent = `${count} domain${count !== 1 ? 's' : ''} tracked`;
  }
}

// Show no domains message
function showNoDomains() {
  const loadingEl = document.getElementById('loading');
  const noDomainsEl = document.getElementById('noDomains');
  const domainListEl = document.getElementById('domainList');
  const countEl = document.getElementById('count');
  
  loadingEl.style.display = 'none';
  noDomainsEl.style.display = 'block';
  domainListEl.style.display = 'none';
  countEl.textContent = 'No domains tracked';
}

// Clear domains for current tab
async function clearDomains() {
  try {
    const tabs = await browser.tabs.query({ active: true, currentWindow: true });
    
    if (tabs.length === 0) {
      return;
    }
    
    const tabId = tabs[0].id;
    
    await browser.runtime.sendMessage({
      action: 'clearDomains',
      tabId: tabId
    });
    
    // Reload domains (should show empty now)
    loadDomains();
  } catch (error) {
    console.error('Error clearing domains:', error);
  }
}

// Initialize popup
document.addEventListener('DOMContentLoaded', () => {
  loadDomains();
  
  // Setup clear button
  const clearBtn = document.getElementById('clearBtn');
  clearBtn.addEventListener('click', clearDomains);
});
