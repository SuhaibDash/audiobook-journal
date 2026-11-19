# V1 requirements

## R-01: Track a book

A user can create a book with a title, author, optional series name, optional
series order, and reading status.

**Acceptance criteria**

- The user can save a new book.
- A book has one of these statuses: Wishlist, Currently listening, Finished,
  DNF.
- More than one book may be marked Currently listening.
- The saved book appears in the appropriate library section.
- The user can change a book's reading status after creating it.
- Series order is either omitted or a positive whole number.

## R-02: Browse reading history

A user can view books grouped by reading status.

**Acceptance criteria**

- The library shows Wishlist, Currently listening, Finished, and DNF sections.
- A user can open a book from any section.

## R-03: Capture an entry

A user can create a note, reflection, or prediction for a book.

**Acceptance criteria**

- The user chooses an entry type.
- The user may provide a positive whole-number chapter or leave it general.
- An entry includes text and a capture timestamp.
- Saving returns the user to the book's entry timeline.
- Entries appear in capture order, oldest first.

## R-04: Persist data locally

A user's books and entries remain available after the app is closed and reopened.

**Acceptance criteria**

- The app does not require an account or internet connection for v1.
- Data is stored locally on the device.
- If a save fails, the app keeps the user's draft visible and explains that it
  was not saved.

## R-05: Track books not finished

A user can mark a book Did Not Finish (DNF) and optionally record why they
stopped, so their reading history includes unfinished books as well.

**Acceptance criteria**

- Use "DNF" as the user-facing status label, picker option, and section title.
- Both standalone books and books in a series can be marked DNF.
- DNF books appear in their own library section and remain accessible.
- Marking a book DNF preserves its existing entries and series metadata; it
  does not change the status of other books in the series.
- The user may add, edit, or clear a free-text "Why I stopped" reason for a DNF
  book. The reason is optional and does not block marking a book DNF.
- The reason is visible on the DNF book's detail screen.
- The user can resume a DNF book by changing its status to Currently listening.
- DNF status and the reason persist across relaunches. Failed saves report an
  error, preserve any reason draft, and leave the last saved state unchanged.

**Design question before implementation**

- Decide whether a reason should remain visible as history after resuming, and
  how to handle stopping the same book again. Do not silently discard a saved
  reason when changing status.
