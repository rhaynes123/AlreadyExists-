# Models Folder

This folder contains all models, services, ViewModels, and business logic for the AlreadyExists? app.

## What Goes Here

### ✅ Models
- Data structures (structs, classes, enums)
- Codable types for API responses
- Example: `AppStoreSearchResult.swift`, `AppError.swift`

### ✅ ViewModels
- Classes conforming to `ObservableObject`
- Manage state for SwiftUI views
- End with `ViewModel` suffix
- Example: `AppSearchViewModel.swift`

### ✅ Services
- Networking layer
- Business logic
- Protocol definitions
- End with `Service` or `Manager` suffix
- Example: `AppStoreService.swift`

### ✅ Protocols
- Service protocols
- Repository protocols
- Example: `AppStoreSearching` protocol

## What Does NOT Go Here

### ❌ SwiftUI Views
- Views belong in the `Views/` folder
- Even view-related models should be in Views if they're view-specific

### ❌ App Entry Point
- `AlreadyExists_App.swift` stays at root level

### ❌ Tests
- Tests belong in the test target, not here

### ❌ Documentation
- Documentation belongs in `docs/` folder

## Naming Conventions

### Files
- Use simple, descriptive names
- ✅ `AppError.swift`
- ❌ `ModelsAppError.swift` (don't prefix with folder name)

### Types
- Models: Noun (e.g., `AppResult`, `AppError`)
- ViewModels: Noun + "ViewModel" (e.g., `AppSearchViewModel`)
- Services: Noun + "Service" (e.g., `AppStoreService`)
- Protocols: Adjective/Verb form (e.g., `AppStoreSearching`)

## Import Guidelines

Most files in this folder should import:
```swift
import Foundation
```

ViewModels also need:
```swift
import Foundation
import SwiftUI
import Combine  // Required for @Published and ObservableObject
```

## Current Contents

- `AppError.swift` - Application error enum
- `AppStoreSearchResult.swift` - API response models
- `AppStoreService.swift` - iTunes Search API service
- `AppSearchViewModel.swift` - Search screen ViewModel

---

For more details, see `docs/CONTRIBUTING.md`
