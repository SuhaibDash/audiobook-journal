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
| R-01 Track a book | In progress | A user can create a book and it appears in the correct section. Changing status and validating series order remain. Data is in memory until R-04 is complete. |
| R-02 Browse reading history | Done | The library groups user-created books by status, and a user can open any book's detail screen. Data is in memory until R-04 is complete. |
| R-03 Capture an entry | In progress | A user can create an entry and see it on the selected book. Chapter validation and explicit capture ordering remain. Entries are in memory until R-04 is complete. |
| R-04 Persist data locally | In progress | The initial SwiftData record schema exists. The model container, repository, save-error flow, and relaunch verification remain. |

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
