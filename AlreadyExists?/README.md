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
3. Run the app: Cmd+R
4. Run tests: Cmd+U

## Contributing
Please read CONTRIBUTING.md for technical guidelines and testing requirements. If you are using AI assistance, also review AGENTS.md for agent-specific instructions.

