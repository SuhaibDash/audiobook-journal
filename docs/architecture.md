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
Book   1 -> many Entries
Book: title, author, optional series name, optional series order, reading status
Entry: type, optional chapter number, body, created timestamp
```

V1 stores series information as optional fields on a book. It does not yet have
a separate Series model.
