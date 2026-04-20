# AlreadyExists-
A spec driven development based app that checks if an app name is already in use.

## Features

- Search by app name to check if the name is already taken
- Paste a short description to find similar existing apps
- Clear feedback: "Name taken" or "Similar names found"
- Loading and error handling with user-friendly messages
- Works on iOS 17+ using SwiftUI

## Architecture

- SwiftUI + MVVM with async/await networking
- URLSession for App Store Search API requests
- Codable, Sendable models
- Swift Testing for unit tests (no third-party frameworks)

### Project Structure
```
AlreadyExists?/
├── Models/          # Models, Services, ViewModels
├── Views/           # SwiftUI views
└── docs/            # Documentation (.md files only)
```

See `docs/CONTRIBUTING.md` for detailed folder guidelines.

---

## How to Run

1. Open AlreadyExists?.xcodeproj in Xcode 15+
2. Select the "AlreadyExists?" app target and a simulator or device
3. Build the project: Cmd+B (verify no errors)
4. Run the app: Cmd+R
5. Run tests: Cmd+U

## Development Workflow

### Before Starting
1. Read **docs/SPEC.md** for feature requirements
2. Read **docs/CONTRIBUTING.md** for technical guidelines
3. Review **docs/BUILD_VERIFICATION.md** for build checklist
4. Check **Models/README.md** and **Views/README.md** for folder guidelines

### During Development
1. ✅ **Place files in correct folders**: `Models/` or `Views/`, NEVER `docs/`
2. ✅ **Use simple file names**: `AppError.swift`, NOT `ModelsAppError.swift`
3. ✅ Build frequently with **Cmd+B**
4. ✅ Check **docs/BUILD_VERIFICATION.md** when creating files
5. ✅ Verify imports match file type (see quick reference)
6. ✅ Run tests with **Cmd+U** after changes

### Before Committing
1. ✅ Build succeeds (Cmd+B) with 0 warnings
2. ✅ All tests pass (Cmd+U)
3. ✅ App runs without crashes (Cmd+R)
4. ✅ Update CHANGELOG.md

## Contributing
Please read `docs/CONTRIBUTING.md` for technical guidelines and testing requirements. If you are using AI assistance, also review `docs/AGENTS.md` for agent-specific instructions.

**Quick Build Check:** See `docs/BUILD_VERIFICATION.md` for a checklist to catch build errors early.

**File Organization:** See `Models/README.md` and `Views/README.md` for folder-specific guidelines.
**⚠️ Important:** After reorganization, see `docs/ACTION_REQUIRED.md` for Xcode integration steps.


