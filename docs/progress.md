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
| R-01 Track a book | Done | A user can create a book with title, author, optional series data, and a reading status; the book appears in its matching library section. Data is in memory until R-04 is complete. |
| R-02 Browse reading history | Done | The library groups user-created books by status, and a user can open any book's detail screen. Data is in memory until R-04 is complete. |
| R-03 Capture an entry | Done | A user can choose an entry type, optionally enter a chapter, write a thought, save it, and immediately see it on the selected book's detail screen. Entries are in memory until R-04 is complete. |
| R-04 Persist data locally | Not started | SwiftData persistence has not been introduced. |

## Completed milestones

- GitHub repository created and connected to the local project.
- Product brief, requirements, architecture notes, decision log, and backlog added.
- SwiftUI iOS app scaffold created and launched in the simulator.
- Library grouped by Wishlist, Currently Listening, and Finished.
- Book-detail navigation flow created.
- Book and Entry models created.
- Story-entry timeline and Add Thought composer created.
- Add Book composer created.

## Current slice

**Persist books and entries locally with SwiftData.**

The app currently keeps books and entries only in memory. The next step is to
replace temporary in-memory state with SwiftData so the user's library remains
after closing and reopening the app.

## Next milestones

1. Persist books and entries locally with SwiftData.
