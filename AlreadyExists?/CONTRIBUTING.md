# CONTRIBUTOR
# AlreadyExists? — iOS App
Version: 1.0 | Status: Draft | Owner: Engineering

## Derived From
SPEC.md: AlreadyExists? v1.0

---

## System Context
The app is a read-only iOS client that consumes an existing API to find out if an iOS app exists.

---

## Platform & Stack
- Language:       Swift 5.9+
- UI Framework:   SwiftUI
- Persistence:    SwiftData (local cache only)
- Min iOS:        17.0
- Networking:     URLSession with async/await
- Architecture:   MVVM + Vertically Sliced Feature Folders


---


### Models
- All models are Swift structs, Codable, Sendable
- Date fields use ISO8601DateFormatter, never assume locale
- Amounts are Decimal, never Double or Float

### Views
- All views should include a preview

### Error Handling
- Define errors as enums conforming to LocalizedError
- Network errors mapped to AppError before reaching ViewModel
- ViewModels expose: @Published var errorState: AppError?
- Never surface raw HTTP status codes to the UI layer

### Security — Non-Negotiable
- Tokens stored in Keychain only (kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
- Nothing sensitive in UserDefaults, NSLog, or print() in production
- Do not all for any sensitive data to be stored in any plain text formats
- #if DEBUG guard any debug logging

---

## Testing Requirements
- Every ViewModel has a unit test covering success, empty, and error states
- Use SwiftTesting only — no third-party test frameworks
- Tests must pass before any PR is considered complete
- AAA pattern: Arrange / Act / Assert, one assertion concept per test
