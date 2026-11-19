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
| R-01 Track a book | In progress | Creation and optional series-order validation are verified. Status-change code exists but runtime verification remains. Newly planned DNF status is not implemented. |
| R-02 Browse reading history | In progress | The original three sections work. Scope expanded to include DNF; that section is not implemented. |
| R-03 Capture an entry | In progress | A user can create an entry, see it on the selected book, and retain it across relaunch. Optional positive chapter validation is verified in the composer. Explicit capture ordering remains to be verified. |
| R-04 Persist data locally | Done | Books and entries survive relaunch. ViewModel failure tests pass; presented previews verify alerts, draft retention, and Cancel. A real in-memory SwiftData context with an injected save error verifies rollback of inserts and edits, retry, and isolation from another context. Physical disk failures were not simulated. |
| R-05 Track books not finished | Not started | DNF status, section, optional reason, and resume behavior are specified. Dated DNF history will remain visible after resuming. |

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
- Repository rollback and retry verified with real SwiftData models and an injected save error.
- Optional series order and chapter validation manually verified, including whitespace handling and invalid input.

## Current slice

**Finish the remaining v1 integrity and validation behavior.**

Local persistence works for books and entries. Controlled failures have been
checked at the repository, ViewModel, and composer layers. Composer number
validation is verified. Remaining work includes explicit entry ordering and
changing a book's reading status. DNF tracking is a newly planned v1 addition.

## Next milestones

1. Verify explicit entry ordering.
2. Support changing a book's reading status.
3. Implement R-05: DNF status, library section, and optional reason.
