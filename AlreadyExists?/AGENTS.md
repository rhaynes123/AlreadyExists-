
# AGENTS.md
# AlreadyExists — iOS App

## Project Overview
See docs/SPEC.md for business context. See CONTRIBUTING.md for full technical spec.
---
## What NOT to Do
- Follow a Test driven development like approach when making features meaning to make a test then implement the feature to the best assumed knowledge. USe the Acceptance Criteria as a guide for the tests.
---

## What NOT to Do
- Do not use UserDefaults for anything sensitive
- Do not introduce Combine — the codebase is async/await only
- Do not create God ViewModels — one ViewModel per feature screen
- Do not skip error handling with try? unless explicitly justified in a comment

---

## How to Run
1. Open AlreadyExists?.xcodeproj in Xcode 15+
4. Run tests: Cmd+U

