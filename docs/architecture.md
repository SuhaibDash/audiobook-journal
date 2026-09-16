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

SwiftData remains the local source for offline use when a backend is added.
Future synchronization coordinates the local and remote stores rather than
replacing local persistence.

The initial SwiftData repository uses the main model context and is isolated to
the main actor. It maps between the domain structs used by the app and the
stored SwiftData records.

Repository invariants:

- Every stored entry belongs to exactly one stored book.
- Domain UUIDs and timestamps survive storage round trips unchanged.
- Unknown stored enum values produce a load error rather than silently changing
  their meaning.
- Entries are returned in ascending `createdAt` order.

## Main models

```text
Book   1 -> many Entries
Book: title, author, optional series name, optional series order, reading status,
created timestamp, updated timestamp
Entry: type, optional chapter number, body, created timestamp, updated timestamp
```

V1 stores series information as optional fields on a book. It does not yet have
a separate Series model.
