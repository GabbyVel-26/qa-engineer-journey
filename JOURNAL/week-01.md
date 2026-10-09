Results from prompt: Review this scenario: is it declarative, one behavior, with a clear expected outcome? Suggest improvements and explain why.

Critique & Evaluation

TC-01: Register with valid data
• Declarative? No. It is highly imperative. It reads like a manual testing script or a sequence of clicks and form inputs (e.g., "completes the first part of the address... completes the remaining..."). Gherkin should focus on what the user is achieving, not how they fill out the UI layout.
• One behavior? Yes. It targets the happy path registration behavior, but the steps are too fragmented.
• Clear outcome? Yes, but Then the account is created and And confirmation message... are redundant. You only need one clear assertion step.
• Sintax Note: You used Scenario: instead of Scenario Outline: but provided an Examples: table. In modern Gherkin, you must use Scenario Outline: (or Scenario Template:) if a table is present. Also, passing name and email multiple times in the table is redundant.

TC-02: Register with an already registered email
• Declarative? Yes. It states the business context and the action cleanly without detailing UI interactions.
• One behavior? Yes. Focuses on the unique email validation constraint.
• Clear outcome? Yes. Asserts the specific error message.

TC-03: Register with empty required data
• Declarative? Yes. It focuses on the action and the expected validation message.
• One behavior? Yes. Focuses on the initial signup form boundaries.
• Clear outcome? Yes. Asserts the native HTML5 validation messages.
• Tag Note: @Scenario Outline is bad practice. Avoid using Gherkin keywords as tags. Cucumber already knows it's an outline because of the keyword.

TC-04: No-register mandatory user fields
• Declarative? No. The step And does not complete the mandatory account details... is awkward. In BDD, we should describe the action the user takes (e.g., submitting an incomplete form) rather than listing what they didn't do inside a step phrase.
• One behavior? Yes. Focuses on the second form's validation.
• Clear outcome? Yes. Asserts the error and the page state.

Suggested Improvements & Why
To fix these issues, we need to abstract UI steps into user intentions, fix Gherkin syntax errors, and group data payloads inside Data Tables to make the Examples tables highly readable.


Why are these changes better?
1. Shifted from Imperative to Declarative (TC-01): Instead of three separate steps detailing which part of the address is being filled out sequentially, a single step And completes their account profile and address information with: is used. This allows your Playwright step definition to handle the form-filling logic cleanly without polluting the business documentation with layout mechanics.
2. Inline Data Tables for Structure: In TC-01, a Data Table was placed right below the step. This separates the operational payload (how fields map to inputs) from the test data iterations in the Examples block, preventing the Examples table from becoming an unreadable, wide row.
3. Simplified Variables: In your original TC-01, you passed "John" as both <new_name> and <name>. Since Automation Exercise automatically passes the initial name down to the second screen profile, you only need to declare it once.
4. Cleaned up Negatives (TC-04): Describing an action negatively ("does not complete") usually results in confusing automation step definitions. It was refactored to an explicit business action: When the shopper submits the account information form leaving the password field blank.
5. Removed Syntax/Tag Anti-patterns: Fixed the Scenario keyword to Scenario Outline in TC-01, stripped away the explicit " " quotes inside the Examples tables (Cucumber interprets text inside columns as strings automatically), and deleted the @Scenario Outline tag.


The other two feature files where drafted using IA, using the second prompt in "week-01-prompt.md" file, which reduced the time spent manually created them and invested the time in reviewed them.