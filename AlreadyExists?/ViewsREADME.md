# Views Folder

This folder contains all SwiftUI views for the AlreadyExists? app.

## What Goes Here

### ✅ SwiftUI Views
- All SwiftUI view structs
- Main screens (e.g., `ContentView.swift`)
- Reusable components (e.g., `AppResultRow.swift`)
- Custom view modifiers
- View-specific helper views

### ✅ View Requirements
- Must import `SwiftUI`
- Must include a `#Preview` for development
- Should be composable and focused

## What Does NOT Go Here

### ❌ ViewModels
- ViewModels belong in `Models/` folder
- They manage state but aren't views themselves

### ❌ Models/Data Types
- Data structures belong in `Models/` folder
- Even if they're only used by views

### ❌ Services/Business Logic
- Belongs in `Models/` folder
- Views should be presentation-only

### ❌ App Entry Point
- `AlreadyExists_App.swift` stays at root level

### ❌ Tests
- Tests belong in the test target

### ❌ Documentation
- Documentation belongs in `docs/` folder

## Naming Conventions

### Files
- Use simple, descriptive names
- ✅ `ContentView.swift`
- ✅ `AppResultRow.swift`
- ❌ `ViewsContentView.swift` (don't prefix with folder name)

### View Names
- Screens: Descriptive noun + "View" (e.g., `ContentView`, `SearchView`)
- Components: Descriptive noun (e.g., `AppResultRow`, `SearchBar`)
- Modifiers: Descriptive (e.g., `CardStyle`, `PrimaryButton`)

## SwiftUI View Template

```swift
import SwiftUI

struct MyView: View {
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        // View implementation
    }
    
    // MARK: - Private Methods (if needed)
}

#Preview {
    MyView()
}
```

## Import Guidelines

All files in this folder should import:
```swift
import SwiftUI
```

If using model types, they're automatically available (no additional import needed as they're in the same module).

## Current Contents

- `ContentView.swift` - Main search interface
- `AppResultRow.swift` - Reusable row for displaying app results

## Best Practices

### ✅ DO:
- Keep views small and focused
- Extract reusable components
- Use view composition
- Add previews to all views
- Use descriptive variable names
- Comment complex view logic

### ❌ DON'T:
- Put business logic in views
- Create massive view files (split them up)
- Skip previews
- Mix view and data logic
- Hardcode values (use view models)

## View Organization

For complex views, consider this structure:
```swift
// MARK: - Main View
struct MyView: View {
    @StateObject private var viewModel = MyViewModel()
    
    var body: some View {
        // Main composition
    }
}

// MARK: - Subviews (if kept in same file)
private struct MySubview: View {
    var body: some View {
        // Subview implementation
    }
}

// MARK: - Preview
#Preview {
    MyView()
}
```

---

For more details, see `docs/CONTRIBUTING.md`
