# Decisions

## 2026-09-13: Build local-first for v1

**Decision:** Persist books and entries on the device with SwiftData; do not
build a backend, authentication, or sync in v1.

**Why:** Immediate, offline capture is the core user need. A local-first v1
keeps the first product slice small while a repository boundary preserves a
path to backend sync as a later learning milestone.

## 2026-09-13: Keep book organization lightweight in v1

**Decision:** Allow multiple currently-listening books. Store optional series
name and series order directly on each book rather than creating a Series model.

**Why:** Listeners may alternate books. Free-text series metadata supports
useful organization without introducing separate series-management screens or
relationships before the app has been used.

## 2026-09-15: Keep domain and storage models separate

**Decision:** Views and view models use `Book` and `Entry` domain structs. A
repository maps them to SwiftData-specific stored records.

**Why:** The app keeps storage details out of presentation code, gains a clear
place for validation and save errors, and preserves a path to a future backend
without giving up offline local storage.

## 2026-09-15: Present entries in capture order

**Decision:** A book's entries appear oldest first by `createdAt`.

**Why:** The resulting timeline follows the listener's experience through the
book and preserves when predictions and reflections were captured.
