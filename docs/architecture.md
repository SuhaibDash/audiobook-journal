# Architecture

## Initial stack

- SwiftUI for the interface
- MVVM to separate interface code from screen behavior
- SwiftData for on-device persistence

## Boundaries

```text
SwiftUI view -> view model -> repository -> SwiftData
```

- A **view** renders state and forwards user actions.
- A **view model** owns screen state and coordinates user actions.
- A **repository** is the app's data-facing API; it loads and saves models.
- **SwiftData** persists the models locally in v1.

The repository boundary lets a future sync layer communicate with a backend
without requiring views to know where their data comes from.

## Main models

```text
Series 1 -> many Books
Book   1 -> many Entries
Entry: type, optional chapter number, body, created timestamp
```
