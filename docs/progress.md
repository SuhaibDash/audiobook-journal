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

## Current slice

**Let the user add a book to the library.**

The library currently contains temporary sample books. The next step is an Add
Book composer that adds a user-created book to the correct status section.

## Next milestones

1. Let the user create a book.
2. Persist books and entries locally with SwiftData.
