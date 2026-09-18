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
| R-01 Track a book | In progress | A user can create and persist a book in the correct section. Changing status and validating series order remain. |
| R-02 Browse reading history | Done | The library groups persisted books by status, and a user can open any book from any section. |
| R-03 Capture an entry | In progress | A user can create an entry, see it on the selected book, and retain it across relaunch. Chapter validation and explicit capture ordering remain. |
| R-04 Persist data locally | In progress | Books and entries survive relaunch. Automated tests verify ViewModel behavior when repository saves throw. Presented failure previews manually verify alerts, draft retention, and Cancel for both composers. Actual SwiftData save-failure recovery remains unverified. |

## Completed milestones

- GitHub repository created and connected to the local project.
- Product brief, requirements, architecture notes, decision log, and backlog added.
- SwiftUI iOS app scaffold created and launched in the simulator.
- Library grouped by Wishlist, Currently Listening, and Finished.
- Book-detail navigation flow created.
- Book and Entry models created.
- Story-entry timeline and Add Thought composer created.
- Add Book composer created.
- SwiftData schema, model mappings, repository, and app-level dependency injection added.
- Book and entry persistence verified across app relaunches.
- Save-result handling added so failed drafts remain visible with an explanation.
- Book and entry save failures covered by ViewModel tests and manual sheet-preview checks.

## Current slice

**Finish the remaining v1 integrity and validation behavior.**

Local persistence works for books and entries. Controlled failures have been
checked at the ViewModel and composer layers. Remaining work includes SwiftData
save-failure recovery, positive-number validation, explicit entry ordering,
and changing a book's reading status.

## Next milestones

1. Verify SwiftData context recovery after a failed save.
2. Validate series and chapter numbers.
3. Support changing a book's reading status.
