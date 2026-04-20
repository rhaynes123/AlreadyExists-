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
- **Place files in correct folders**: `Models/` for models/services/ViewModels, `Views/` for SwiftUI views
- Run tests (`Cmd+U`) after implementation

---

## What NOT to Do
- ❌ **Do NOT create Swift files in `docs/` folder** — docs is for `.md` files ONLY
- ❌ **Do NOT use prefixed names** like `ModelsAppError.swift` or `ViewsContentView.swift`
- ❌ Do not use UserDefaults for anything sensitive
- **Do not introduce Combine** — EXCEPTION: SwiftUI ViewModels with @Published MUST import Combine (required by Apple frameworks)
- Do not create God ViewModels — one ViewModel per feature screen
- Do not skip error handling with try? unless explicitly justified in a comment
- **Do not assume files are in targets** — when creating new files, verify they compile

---

## ⚠️ CRITICAL: File Organization Rules

### Correct File Paths
```
✅ CORRECT:
Models/AppError.swift
Models/AppStoreService.swift
Models/AppSearchViewModel.swift
Views/ContentView.swift
Views/AppResultRow.swift
docs/SPEC.md
docs/CONTRIBUTING.md

❌ WRONG:
docs/AppError.swift                    # Swift files don't belong in docs/
ModelsAppError.swift                   # Don't prefix with folder name
ViewsContentView.swift                 # Don't prefix with folder name
AppError.swift (in root)               # Should be in Models/ folder
ContentView.swift (in root)            # Should be in Views/ folder
```

### Quick Reference
- **Models, Services, ViewModels** → `Models/` folder
- **SwiftUI Views** → `Views/` folder  
- **Documentation (*.md)** → `docs/` folder
- **Tests** → Test target (separate from main app)

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
1. ✅ **Verify correct folder** (`Models/` or `Views/`, NEVER `docs/`)
2. ✅ **Use simple file name** (`AppError.swift`, NOT `ModelsAppError.swift`)
3. ✅ Add all required imports (see CONTRIBUTING.md table)
4. ✅ Build project immediately (`Cmd+B`)
5. ✅ Fix any scope/import errors before proceeding
6. ✅ Verify file appears in Xcode project navigator
7. ✅ Check target membership in file inspector
8. ✅ Add tests if applicable
9. ✅ Run tests (`Cmd+U`)

### Common Pitfalls & Solutions

| Pitfall | Detection | Fix |
|---------|-----------|-----|
| **Swift files in docs/** | File path starts with `docs/` | Move to `Models/` or `Views/` |
| **Prefixed file names** | Name like `ModelsAppError.swift` | Rename to `AppError.swift` and move to `Models/` |
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
