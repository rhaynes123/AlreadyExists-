# CONTRIBUTOR
# AlreadyExists? — iOS App/ MacOS App
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
- Architecture:   View/Models + Vertically Sliced Feature Folders as new Features become needed


---

## Project Structure

⚠️ **CRITICAL: Swift Source Files MUST NOT be placed in the `docs/` folder!**

```
AlreadyExists?/
├── AlreadyExists_App.swift          # Main app entry point
├── Models/                          # All models, services, ViewModels
│   ├── AppError.swift              # Error definitions
│   ├── AppStoreSearchResult.swift  # API response models
│   ├── AppStoreService.swift       # Network service layer
│   └── AppSearchViewModel.swift    # ViewModels
├── Views/                           # All SwiftUI views
│   ├── ContentView.swift           # Main views
│   └── AppResultRow.swift          # Reusable view components
└── docs/                            # Documentation ONLY (NO .swift files)
    ├── SPEC.md
    ├── CONTRIBUTING.md
    ├── AGENTS.md
    ├── IMPLEMENTATION.md
    └── CHANGELOG.md
```

### ⛔ DO NOT:
- ❌ Create Swift files in `docs/` folder
- ❌ Create Swift files with prefixed names like `ModelsAppError.swift`
- ❌ Create Swift files with prefixed names like `ViewsContentView.swift`

### ✅ DO:
- ✅ Place models in `Models/` folder with simple names: `AppError.swift`
- ✅ Place views in `Views/` folder with simple names: `ContentView.swift`
- ✅ Place documentation in `docs/` folder with `.md` extension

### Models Folder (`Models/`)
- All models are Swift structs, Codable, Sendable
- ViewModels (ending in `ViewModel`) go here
- Services (ending in `Service`) go here
- Protocols that define service contracts go here
- Date fields use ISO8601DateFormatter, never assume locale
- Amounts are Decimal, never Double or Float

### Views Folder (`Views/`)
- All SwiftUI views go here
- All views should include a `#Preview`
- Keep views focused and composable

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
---

## Build Verification Checklist

### Before Committing Code
Run these checks to catch build errors early:

1. **Build the Project** (`Cmd+B`)
   - Fix all compiler errors and warnings
   - Zero warnings policy for new code

2. **Run All Tests** (`Cmd+U`)
   - All tests must pass
   - Check test coverage for new code

3. **Common Import Issues**
   - SwiftUI ViewModels using `@Published` MUST import `Combine`
   - Foundation types like `URLSession` MUST import `Foundation`
   - SwiftUI views MUST import `SwiftUI`
   
4. **Target Membership**
   - New files must be added to the correct Xcode target
   - Check file inspector to ensure app target is selected
   - Test files must be in test target only

5. **Dependency Check**
   - If Type X uses Type Y, both must be in same target or Y must be in framework
   - Protocol conformances require all necessary imports

### Required Imports by File Type

| File Type | Required Imports |
|-----------|-----------------|
| SwiftUI View | `import SwiftUI` |
| ViewModel with @Published | `import Foundation`, `import SwiftUI`, `import Combine` |
| Model (Codable) | `import Foundation` |
| Service (URLSession) | `import Foundation` |
| Tests | `import Testing`, `@testable import AlreadyExists_` |

### Automated Checks (Pre-commit)
Before pushing code, verify:
```bash
# Build succeeds
xcodebuild -scheme "AlreadyExists?" -destination 'platform=iOS Simulator,name=iPhone 15' build

# Tests pass
xcodebuild -scheme "AlreadyExists?" -destination 'platform=iOS Simulator,name=iPhone 15' test
```

### Common Build Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `Type does not conform to ObservableObject` | Missing `Combine` import | Add `import Combine` to ViewModel |
| `Cannot find [Type] in scope` | File not in target or missing import | Check target membership in Xcode |
| `Initializer 'init(wrappedValue:)' not available` | Missing module import | Add required framework import |
| `No such module` | Framework not linked | Add framework in Build Phases |
| `Use of undeclared type` | Missing import or typo | Verify type name and import statement |

### New File Checklist
When adding a new Swift file:
- [ ] **File is in correct folder** (`Models/` or `Views/`, NEVER `docs/`)
- [ ] **File has correct name** (e.g., `AppError.swift`, NOT `ModelsAppError.swift`)
- [ ] File added to correct target (App or Tests)
- [ ] All required imports present
- [ ] File compiles individually (`Cmd+B`)
- [ ] Preview works (for SwiftUI views)
- [ ] Tests added (for Models/ViewModels)
- [ ] No warnings generated

