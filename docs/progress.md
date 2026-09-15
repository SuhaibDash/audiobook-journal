# Progress log

This document connects the product requirements to the work completed in the
app. A requirement is only **Done** when its acceptance criteria work in the
running app—not merely when its models or placeholder UI exist.

## Status legend

- **Not started** — no implementation work yet.
- **In progress** — some supporting code or UI exists, but at least one
  acceptance criterion remains incomplete.
- **Done** — every acceptance criterion has been verified in the running app.

## V1 requirements

| Requirement | Status | Evidence / remaining work |
| --- | --- | --- |
| R-01 Track a book | In progress | `Book` and `ReadingStatus` models exist. The library uses sample books; the user cannot create or save a book yet. |
| R-02 Browse reading history | In progress | Books are grouped by status and open a detail screen. The data is temporary sample data, not a user's reading history. |
| R-03 Capture an entry | In progress | `Entry` and `EntryType` models exist. The user cannot create an entry yet, and seeded entries are not shown on the detail screen yet. |
| R-04 Persist data locally | Not started | SwiftData persistence has not been introduced. |

## Completed milestones

- GitHub repository created and connected to the local project.
- Product brief, requirements, architecture notes, decision log, and backlog added.
- SwiftUI iOS app scaffold created and launched in the simulator.
- Library grouped by Wishlist, Currently Listening, and Finished.
- Book-detail navigation flow created.
- Book and Entry models created.

## Current slice

**Show the existing entries for the selected book on its detail screen.**

The view model can now return entries for a specific book. The next step is to
pass those entries into `BookDetailView` and replace the empty Thoughts state
with a timeline.

## Next milestones

1. Show entries on a book-detail screen.
2. Let the user create an entry.
3. Let the user create a book.
4. Persist books and entries locally with SwiftData.
