````markdown
# QA Engineer Journey

   ![status](https://img.shields.io/badge/status-in%20progress-yellow)

   Practice repository and technical portfolio — transition from senior manual QA
   to QA automation / AI-assisted QA. Test cases are written as Gherkin
   (test-as-code) so they can be automated later without being rewritten.
   Each folder maps to a stage of the learning plan.

   ## Anchor app
   [Automation Exercise](https://automationexercise.com) — public UI + API,
   used to practice manual testing, E2E automation, and API testing.

   ## Example: test case as code
   ```gherkin
   @negative @TC-02
   Scenario: Register with an already registered email
     Given an account already exists for "existing.user@example.com"
     When the shopper signs up with that email
     Then an error message "Email Address already exist!" is displayed
   ```

   ## Repository structure
   | Folder | Content |
   |---|---|
   | `features/` | Gherkin test cases for the anchor app (UI and API) |
   | `docs/` | Anchor app notes and manual execution log |
   | `api-testing/` | Postman collections + Newman (in progress) |
   | `e2e-playwright/` | Playwright + TypeScript + playwright-bdd suite (in progress) |
   | `python-scripts/` | Python utility scripts (in progress) |
   | `ci-cd/` | GitHub Actions pipelines (in progress) |
   | `ai-prompts/` | Documented AI prompts per week |
   | `JOURNAL/` | Weekly learning log |

   ## How to navigate
   Each folder has its own README with details. Start with
   `features/ui/user-registration.feature` to see the starting point.

   ## Quality gates
   Gherkin files are linted with `gherkin-lint` (`npm run lint:features`).

   ## Stack (in progress)
   Git, GitHub Actions, Gherkin, Postman, Newman, Playwright, TypeScript, Cucumber, Python.
````