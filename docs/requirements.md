# V1 requirements

## R-01: Track a book

A user can create a book with a title, author, optional series name, optional
series order, and reading status.

**Acceptance criteria**

- The user can save a new book.
- A book has one of these statuses: Want to read, Currently listening, Finished.
- More than one book may be marked Currently listening.
- The saved book appears in the appropriate library section.

## R-02: Browse reading history

A user can view books grouped by reading status.

**Acceptance criteria**

- The library shows Want to read, Currently listening, and Finished sections.
- A user can open a book from any section.

## R-03: Capture an entry

A user can create a note, reflection, or prediction for a book.

**Acceptance criteria**

- The user chooses an entry type.
- The user may provide a chapter number or leave it general.
- An entry includes text and a capture timestamp.
- Saving returns the user to the book's entry timeline.

## R-04: Persist data locally

A user's books and entries remain available after the app is closed and reopened.

**Acceptance criteria**

- The app does not require an account or internet connection for v1.
- Data is stored locally on the device.
