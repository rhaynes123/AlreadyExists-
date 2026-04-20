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

---

## How to Run

1. Open AlreadyExists?.xcodeproj in Xcode 15+
2. Select the "AlreadyExists?" app target and a simulator or device
3. Build the project: Cmd+B (verify no errors)
4. Run the app: Cmd+R
5. Run tests: Cmd+U

## Development Workflow

### Before Starting
1. Read **SPEC.md** for feature requirements
2. Read **CONTRIBUTING.md** for technical guidelines
3. Review **BUILD_VERIFICATION.md** for build checklist

### During Development
1. ✅ Build frequently with **Cmd+B**
2. ✅ Check **BUILD_VERIFICATION.md** when creating files
3. ✅ Verify imports match file type (see quick reference)
4. ✅ Run tests with **Cmd+U** after changes

### Before Committing
1. ✅ Build succeeds (Cmd+B) with 0 warnings
2. ✅ All tests pass (Cmd+U)
3. ✅ App runs without crashes (Cmd+R)
4. ✅ Update CHANGELOG.md

## Contributing
Please read CONTRIBUTING.md for technical guidelines and testing requirements. If you are using AI assistance, also review AGENTS.md for agent-specific instructions.

**Quick Build Check:** See BUILD_VERIFICATION.md for a checklist to catch build errors early.

