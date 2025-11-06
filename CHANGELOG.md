# Changelog

All notable changes to Domain Tracker Safari Extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-11-06

### Added
- Initial release of Domain Tracker Safari Extension
- Domain tracking functionality using webRequest API
- Real-time monitoring of all network requests per tab
- Clean and modern popup UI showing tracked domains
- Clear button to reset domain list for current tab
- Domain count display in popup footer
- macOS wrapper application for Safari extension
- Automatic cleanup when tabs are closed
- Support for macOS 10.14+ and Safari 14+
- Complete documentation:
  - README.md with installation instructions
  - QUICKSTART.md for quick setup
  - ARCHITECTURE.md with technical details
  - TROUBLESHOOTING.md for common issues
- Custom extension icon (globe with dots)
- Bilingual documentation (English/Russian)

### Features
- 🌐 Track all domains from web requests
- 📊 Display unique domain count
- 🧹 Clear domains for specific tab
- ⚡ Lightweight and fast
- 🎨 Native macOS design
- 🔒 Privacy-focused (no data sent externally)
- 💾 In-memory storage only
- 🔄 Automatic tab cleanup

### Technical Details
- Manifest V3 web extension
- Background service worker for request monitoring
- Popup interface for domain display
- Swift-based macOS app wrapper
- Xcode project structure
- Asset catalog with multiple icon sizes
- Entitlements for app sandboxing

### Documentation
- Installation guide with step-by-step instructions
- Architecture documentation with diagrams
- Troubleshooting guide for common issues
- Quick start guide for users and developers
- API reference and extension points
- Code examples and customization guide

### Developer Experience
- Clean project structure
- Well-commented code
- Modular design
- Easy to extend and customize
- Debug-friendly with console logging
- Safari Web Inspector integration

## [Unreleased]

### Planned Features
- [ ] Export domain list to file
- [ ] Search/filter domains
- [ ] Domain statistics (request count per domain)
- [ ] Domain blocking/allowlist
- [ ] Grouping by top-level domain
- [ ] Request type filtering (XHR, scripts, images, etc.)
- [ ] History between sessions
- [ ] Dark mode support
- [ ] Custom themes
- [ ] Keyboard shortcuts
- [ ] Context menu integration
- [ ] Notifications for new domains

### Possible Improvements
- [ ] Unit tests for JavaScript code
- [ ] UI tests with Xcode UI Testing
- [ ] Continuous Integration setup
- [ ] Automated release process
- [ ] Localization for more languages
- [ ] Performance optimizations
- [ ] Memory usage monitoring
- [ ] Analytics (privacy-respecting)

---

## Version History Summary

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2024-11-06 | Initial release with core functionality |

---

## Upgrade Guide

### From Nothing to 1.0.0

This is the first release. Follow the installation instructions in README.md.

---

## Breaking Changes

None yet (this is the initial release).

---

## Deprecations

None yet (this is the initial release).

---

## Security

### Version 1.0.0

- App Sandbox enabled
- No external data transmission
- In-memory only storage
- No persistent tracking
- No analytics or telemetry

### Reporting Security Issues

If you discover a security vulnerability, please email the maintainer or create a private security advisory on GitHub.

Do NOT create public issues for security vulnerabilities.

---

## Contributors

- Initial development by the project maintainer
- Built with Safari Web Extensions technology
- Uses standard WebExtensions APIs

---

## Links

- [Repository](https://github.com/tiomat/safari-domain-extention)
- [Issues](https://github.com/tiomat/safari-domain-extention/issues)
- [Safari Web Extensions Documentation](https://developer.apple.com/documentation/safariservices/safari_web_extensions)
