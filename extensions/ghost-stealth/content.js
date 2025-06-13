// navigator.webdriver
Object.defineProperty(navigator, 'webdriver', {
  get: () => false,
});

// navigator.languages
Object.defineProperty(navigator, 'languages', {
  get: () => ['en-US', 'en']
});

// navigator.plugins
Object.defineProperty(navigator, 'plugins', {
  get: () => [1, 2, 3], // dummy non-zero array
});

// navigator.mimeTypes
Object.defineProperty(navigator, 'mimeTypes', {
  get: () => [1, 2, 3], // dummy non-zero array
});

// navigator.hardwareConcurrency
Object.defineProperty(navigator, 'hardwareConcurrency', {
  get: () => 4, // typical quad-core CPU
});

// navigator.deviceMemory
Object.defineProperty(navigator, 'deviceMemory', {
  get: () => 8, // typical desktop RAM in GB
});

// navigator.platform
Object.defineProperty(navigator, 'platform', {
  get: () => 'Win32', // or 'Linux x86_64' if you prefer
});

// navigator.userAgent
Object.defineProperty(navigator, 'userAgent', {
  get: () => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) ' +
             'AppleWebKit/537.36 (KHTML, like Gecko) ' +
             'Chrome/125.0.0.0 Safari/537.36',
});

// navigator.permissions.query spoof (to avoid headless detection)
const originalQuery = window.navigator.permissions.query;
window.navigator.permissions.query = (parameters) => (
  parameters.name === 'notifications'
    ? Promise.resolve({ state: Notification.permission })
    : originalQuery(parameters)
);
