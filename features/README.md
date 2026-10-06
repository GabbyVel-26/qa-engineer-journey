# Features (Gherkin test cases)

Test cases for the anchor app, written as Gherkin `.feature` files (test-as-code).

## Structure

| Folder | Content |
|---|---|
| `ui/` | User-interface scenarios (later automated with Playwright + playwright-bdd) |
| `api/` | API scenarios (Postman/Newman first, then automated) |

## Conventions

- One `Feature` per file; file name in kebab-case (e.g. `user-registration.feature`).
- Language: English. Keywords: `Feature`, `Background`, `Scenario`, `Scenario Outline`, `Given`, `When`, `Then`, `And`.
- Declarative style: describe **behavior**, not click-by-click UI steps.
- One behavior per scenario; scenario names state the expected outcome.
- Tags: `@ui` / `@api` (layer), `@smoke` / `@regression` (suite), `@negative` (error paths), `@TC-XX` (unique ID).
- Test data: use fake emails on `example.com`; never real personal data.
- Validated by `npm run lint:features` locally and by CI on every PR.