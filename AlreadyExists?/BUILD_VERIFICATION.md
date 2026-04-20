# BUILD_VERIFICATION.md
# Quick Build Verification Guide

## 🚨 Run These Commands After ANY Code Change

### 1. Immediate Build Check
```
Cmd+B
```
**Expected:** ✅ Build Succeeded (0 errors, 0 warnings)

### 2. Test Verification
```
Cmd+U
```
**Expected:** ✅ All tests pass

### 3. Runtime Verification (for UI changes)
```
Cmd+R
```
**Expected:** ✅ App launches without crash

---

## 📋 New File Checklist

When creating a new Swift file, verify ALL of these:

- [ ] **File is in correct folder** (`Models/` or `Views/`, NEVER `docs/`)
- [ ] **File has simple name** (`AppError.swift`, NOT `ModelsAppError.swift`)
- [ ] **File visible in Xcode Project Navigator** (left sidebar)
- [ ] **Target Membership set correctly**
  - App files → "AlreadyExists?" target
  - Test files → "AlreadyExists?Tests" target
- [ ] **Required imports present** (see table below)
- [ ] **File compiles** (Cmd+B shows no errors)
- [ ] **No warnings** (Xcode warning count = 0)
- [ ] **Tests added** (for Models/ViewModels/Services)

---

## 📁 File Organization Rules

### ✅ Correct File Paths
```
Models/AppError.swift              ✅ Model in Models folder
Models/AppStoreService.swift       ✅ Service in Models folder
Models/AppSearchViewModel.swift    ✅ ViewModel in Models folder
Views/ContentView.swift            ✅ View in Views folder
Views/AppResultRow.swift           ✅ View component in Views folder
docs/SPEC.md                       ✅ Documentation in docs folder
```

### ❌ Wrong File Paths
```
docs/AppError.swift                ❌ Swift files don't belong in docs/
ModelsAppError.swift               ❌ Don't prefix with folder name
ViewsContentView.swift             ❌ Don't prefix with folder name
AppError.swift (at root)           ❌ Should be in Models/ folder
ContentView.swift (at root)        ❌ Should be in Views/ folder
```

---

## 🔍 Required Imports Reference

Copy these import blocks based on file type:

### SwiftUI View
```swift
import SwiftUI
```

### SwiftUI ViewModel (with @Published)
```swift
import Foundation
import SwiftUI
import Combine  // REQUIRED for @Published and ObservableObject
```

### Model (Codable)
```swift
import Foundation
```

### Service (URLSession, networking)
```swift
import Foundation
```

### Test File
```swift
import Testing
import Foundation
@testable import AlreadyExists_
```

### Error Type
```swift
import Foundation  // for LocalizedError
```

---

## 🐛 Common Build Errors

### Error: "Type 'X' does not conform to protocol 'ObservableObject'"
**Cause:** Missing Combine import  
**Fix:**
```swift
import Combine  // Add this line
```

### Error: "Cannot find 'SomeType' in scope"
**Cause:** File not in build target OR missing import  
**Fix:**
1. Check file inspector (right sidebar) → Target Membership
2. Verify all required imports are present
3. Rebuild: Cmd+Shift+K, then Cmd+B

### Error: "Initializer 'init(wrappedValue:)' is not available"
**Cause:** Missing framework import (usually Combine)  
**Fix:**
```swift
import Combine  // For @Published
```

### Error: "No such module 'AlreadyExists_'"
**Cause:** Module not built or test target misconfigured  
**Fix:**
1. Clean build folder: Cmd+Shift+K
2. Build app target first: Cmd+B
3. Then run tests: Cmd+U

---

## 🎯 Pre-Commit Verification

Before committing, ensure:

1. ✅ **Build succeeds:** `Cmd+B` → 0 errors
2. ✅ **No warnings:** Warning count in Xcode = 0
3. ✅ **Tests pass:** `Cmd+U` → All tests green
4. ✅ **App runs:** `Cmd+R` → No crashes
5. ✅ **Previews work:** All SwiftUI previews render

### Command Line Verification (Optional)
```bash
# Build
xcodebuild -scheme "AlreadyExists?" \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  clean build

# Test
xcodebuild -scheme "AlreadyExists?" \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  test
```

---

## 🔧 Quick Fixes

### "Clean Build Folder" (fixes 90% of weird errors)
```
Cmd+Shift+K
```
Then rebuild: `Cmd+B`

### "Derived Data Issues"
1. Xcode → Settings → Locations
2. Click arrow next to Derived Data path
3. Delete DerivedData folder for this project
4. Restart Xcode
5. Rebuild: `Cmd+B`

### "Target Membership Issues"
1. Select file in Project Navigator
2. Open File Inspector (right sidebar, first tab)
3. Under "Target Membership", check appropriate target:
   - ✅ AlreadyExists? (for app files)
   - ✅ AlreadyExists?Tests (for test files)

---

## 📊 Build Health Metrics

Maintain these standards:

| Metric | Target | Current |
|--------|--------|---------|
| Compiler Errors | 0 | Check with Cmd+B |
| Compiler Warnings | 0 | Check in Issue Navigator |
| Test Pass Rate | 100% | Check with Cmd+U |
| Build Time | < 10s | Optimize if exceeding |

---

## 🚀 Best Practices

### DO:
- ✅ Build after EVERY file creation
- ✅ Build after EVERY significant code change
- ✅ Run tests before committing
- ✅ Keep warning count at zero
- ✅ Check Xcode's Issue Navigator frequently

### DON'T:
- ❌ Create multiple files before building
- ❌ Ignore warnings ("I'll fix them later")
- ❌ Commit without running tests
- ❌ Assume files are in correct target
- ❌ Skip import statements

---

## 📖 Related Documentation

- **CONTRIBUTING.md** - Full technical guidelines
- **AGENTS.md** - AI-specific development rules
- **SPEC.md** - Feature requirements
- **IMPLEMENTATION.md** - Architecture details

---

**Remember:** Building early and often prevents hours of debugging later!
