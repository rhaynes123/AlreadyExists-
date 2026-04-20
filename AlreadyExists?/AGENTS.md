# AGENTS.md
# AlreadyExists — iOS App/ MacOS App

## Project Overview
See docs/SPEC.md for business context. See CONTRIBUTING.md for full technical spec.

---

## What TO Do
- Follow a Test driven development like approach when making features meaning to make a test then implement the feature to the best assumed knowledge. Use the Acceptance Criteria as a guide for the tests.
- **VERIFY BUILDS IMMEDIATELY**: After creating or modifying files, check for build errors with `Cmd+B`
- **Check all required imports**: Use the "Required Imports by File Type" table in CONTRIBUTING.md
- **Verify target membership**: Ensure new files are added to the correct Xcode target
- Run tests (`Cmd+U`) after implementation

---

## What NOT to Do
- Do not use UserDefaults for anything sensitive
- **Do not introduce Combine** — EXCEPTION: SwiftUI ViewModels with @Published MUST import Combine (required by Apple frameworks)
- Do not create God ViewModels — one ViewModel per feature screen
- Do not skip error handling with try? unless explicitly justified in a comment
- **Do not assume files are in targets** — when creating new files, verify they compile

---

## Critical Build Requirements

### SwiftUI ViewModel Pattern
```swift
import Foundation
import SwiftUI
import Combine  // ⚠️ REQUIRED for @Published and ObservableObject

@MainActor
final class MyViewModel: ObservableObject {
    @Published var state: String = ""
    // ...
}
```

### File Creation Checklist
When creating new Swift files:
1. ✅ Add all required imports (see CONTRIBUTING.md table)
2. ✅ Build project immediately (`Cmd+B`)
3. ✅ Fix any scope/import errors before proceeding
4. ✅ Verify file appears in Xcode project navigator
5. ✅ Check target membership in file inspector
6. ✅ Add tests if applicable
7. ✅ Run tests (`Cmd+U`)

### Common Pitfalls & Solutions

| Pitfall | Detection | Fix |
|---------|-----------|-----|
| Missing Combine import | `ObservableObject` conformance error | Add `import Combine` |
| File not in target | `Cannot find type in scope` | Add file to app target in Xcode |
| Wrong import order | Various compilation errors | Follow: Foundation → SwiftUI → Combine |
| Missing @testable | Tests can't access internal types | Add `@testable import AlreadyExists_` |

### Immediate Verification Steps
After ANY code change:
```bash
# 1. Build (must succeed)
Cmd+B

# 2. Check for warnings (should be zero)
# 3. Run tests if applicable
Cmd+U

# 4. Run app in simulator if UI changes
Cmd+R
```

---

## How to Run
1. Open AlreadyExists?.xcodeproj in Xcode 15+
2. Build project: `Cmd+B` (verify no errors)
3. Run tests: `Cmd+U` (all tests must pass)
4. Run app: `Cmd+R`

---

## ChangeLog
- Make sure to update the CHANGELOG.md file with any important changes
- Document any new build requirements or dependency changes
