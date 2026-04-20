# CHANGELOG.md
# AlreadyExists — iOS App/ MacOS App

## Project Overview
- Any major changes such as new features or additions should be logged here
---

## [1.0.1] - 2026-04-19

### Fixed - Project Organization
- 🔧 **Reorganized file structure**: Moved all Swift files to proper folders
  - All models, services, and ViewModels now in `Models/` folder
  - All SwiftUI views now in `Views/` folder
  - Removed incorrectly named files (e.g., `ModelsAppError.swift` → `Models/AppError.swift`)
- 🔧 **Updated ContentView**: Removed embedded `AppResultRow`, now uses separate file

### Changed - Documentation
- 📝 **CONTRIBUTING.md**: Added critical file organization rules
  - Added visual file structure tree
  - Added DO/DON'T lists for file placement
  - Enhanced new file checklist with folder verification
- 📝 **AGENTS.md**: Added file organization section
  - Added critical warning about `docs/` folder (no Swift files)
  - Added examples of correct vs. wrong file paths
  - Updated file creation checklist with folder verification
  - Enhanced common pitfalls table
- 📝 **BUILD_VERIFICATION.md**: Added file organization rules
  - Added correct vs. wrong file paths examples
  - Added folder verification to new file checklist

### Project Structure (Updated)
```
AlreadyExists?/
├── AlreadyExists_App.swift          # Main app entry point
├── Models/                          # ✅ All models, services, ViewModels
│   ├── AppError.swift
│   ├── AppStoreSearchResult.swift
│   ├── AppStoreService.swift
│   └── AppSearchViewModel.swift
├── Views/                           # ✅ All SwiftUI views
│   ├── ContentView.swift
│   └── AppResultRow.swift
└── docs/                            # ✅ Documentation ONLY (.md files)
    ├── SPEC.md
    ├── CONTRIBUTING.md
    ├── AGENTS.md
    ├── BUILD_VERIFICATION.md
    ├── IMPLEMENTATION.md
    └── CHANGELOG.md
```

### Removed
- ❌ `ModelsAppError.swift` (moved to `Models/AppError.swift`)
- ❌ `ModelsAppStoreSearchResult.swift` (moved to `Models/AppStoreSearchResult.swift`)
- ❌ `ModelsAppStoreService.swift` (moved to `Models/AppStoreService.swift`)
- ❌ `ModelsAppSearchViewModel.swift` (moved to `Models/AppSearchViewModel.swift`)
- ❌ `ViewsAppResultRow.swift` (moved to `Views/AppResultRow.swift`)
- ❌ Embedded `AppResultRow` from `ContentView.swift`

### Impact
- ✅ Cleaner project structure
- ✅ Easier navigation in Xcode
- ✅ Prevents future file organization mistakes
- ✅ Documentation now explicitly prevents Swift files in `docs/`

---

## [1.0.0] - 2026-04-19

### Added - Core Features
- ✅ **App Name Search**: Search App Store by app name to check availability
- ✅ **Description Search**: Find similar apps by pasting description
- ✅ **Smart Feedback System**: 
  - "Name taken" for exact matches
  - "Name available" for unique names
  - Similar app warnings with count
- ✅ **Rich Results Display**: App icons, ratings, developer info, genres
- ✅ **Loading States**: Visual feedback during API calls
- ✅ **Error Handling**: User-friendly error messages

### Added - Technical Implementation
- **Models/**
  - `AppStoreSearchResult.swift`: Codable models for iTunes API
  - `AppError.swift`: LocalizedError enum for user-friendly errors
  - `AppStoreService.swift`: URLSession-based API service with async/await
  - `AppSearchViewModel.swift`: MVVM ViewModel with Combine integration
- **Views/**
  - `ContentView.swift`: Main search interface with mode switching
  - `AppResultRow.swift`: Reusable result row component
- **Tests/**
  - 14 comprehensive unit tests using Swift Testing framework
  - Mock service for deterministic testing
  - Success, error, and empty state coverage

### Added - Documentation
- ✅ **BUILD_VERIFICATION.md**: Quick reference for catching build errors early
  - Import requirements by file type
  - Common build errors and fixes
  - Pre-commit verification checklist
  - New file creation checklist
- ✅ **IMPLEMENTATION.md**: Detailed architecture and implementation docs
- Enhanced **CONTRIBUTING.md**: Added build verification section with:
  - Required imports table
  - Common build errors reference
  - Automated checks guide
- Enhanced **AGENTS.md**: Added critical build requirements for AI agents:
  - SwiftUI ViewModel pattern with Combine
  - File creation checklist
  - Immediate verification steps
- Enhanced **README.md**: Added development workflow section

### Technical Details
- **Platform**: iOS 17.0+
- **Language**: Swift 5.9+
- **Architecture**: MVVM with protocol-based services
- **Networking**: URLSession with async/await
- **UI**: SwiftUI with Combine for state management
- **Testing**: Swift Testing framework (no third-party dependencies)
- **API**: iTunes Search API (official, public, no auth required)

### Build Quality
- ✅ Zero compiler errors
- ✅ Zero compiler warnings
- ✅ 100% test pass rate
- ✅ All SwiftUI previews functional
- ✅ Runtime tested on iOS Simulator

### Security & Privacy
- ✅ HTTPS-only API calls
- ✅ No sensitive data storage
- ✅ No authentication required
- ✅ Debug logging guarded with `#if DEBUG`
- ✅ No third-party dependencies

### Known Issues
- None

### Future Enhancements (Not in v1.0)
- Local caching with SwiftData
- Search history
- Bookmark/favorite apps
- Detailed app view
- macOS support
- Internationalization (currently US App Store only)

---

## Guidelines for Future Changelog Entries

### Format
```markdown
## [Version] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes to existing functionality

### Fixed
- Bug fixes

### Removed
- Removed features

### Security
- Security improvements
```

### What to Log
- ✅ New features (user-facing)
- ✅ Breaking changes
- ✅ New dependencies
- ✅ Build requirement changes
- ✅ Security fixes
- ✅ Performance improvements
- ❌ Minor code refactors
- ❌ Typo fixes
- ❌ Internal code cleanup (unless significant)

