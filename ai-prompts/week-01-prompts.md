1. Review this scenario: is it declarative, one behavior, with a clear expected outcome? Suggest improvements and explain why.

2. You are a senior QA engineer who writes Gherkin.
      Context: anchor app is automationexercise.com. I'm converting the site's
      published test cases into Gherkin scenarios for my repo.

      Style rules:
      - English, declarative (behavior, not clicks), one behavior per scenario
      - Tags: @ui + feature tag, @smoke or @negative, @TC-XX (same number as the site)
      - Actor: "the shopper". Fake data on example.com. No selectors or URLs in steps
      - Background for shared preconditions; Scenario Outline for data variations

      My own examples (follow this style exactly):
            # Source: automationexercise.com/test_cases, Test Case 1 & 5
            @ui @registration
            Feature: User registration
            As a new shopper
            I want to create an account
            So that I can place orders and track them

            Background:
            Given the shopper is on the login and signup page

            @smoke @TC-01
            Scenario Outline: Register with valid data
            When the shopper signs up as "<name>" with "<email>"
            And completes their account profile and address information with:
            | password   | first_name   | last_name   | address   | country   | state   | city   | zipcode   | mobile_number   |
            | <password> | <first_name> | <last_name> | <address> | <country> | <state> | <city> | <zipcode> | <mobile_number> |
            Then the account should be successfully created with the confirmation message "ACCOUNT CREATED!"

            Examples:
                  |name|email|password|first_name|last_name|address|country|state|city|zipcode|mobile_number|
                  |"John"|"john.doe+1@example.com"|"password"|"John"|"Doe"|"123 Main St"|"United States"|"California"|"Los Angeles"|"90210"|"1234567890"|

            @negative @TC-02
            Scenario: Register with an already registered email
            Given an account already exists for "john.doe+1@example.com"
            When the shopper attempts to sign up with "john.doe+1@example.com"
            Then an error message "Email Address already exist!" is displayed

            @negative @TC-03
            Scenario Outline: Register with empty required data
            When the shopper signs up with "<name>" and "<email>"
            Then an error message "<error_message>" is displayed
            And the shopper remains on the registration page

            Examples:
                  | name | email | error_message |
                  | " "    | " " | "Please fill up this field." |
                  | "John" | "  " | "Please fill up this field." |
                  | "  "   | "john.doe+1@example.com" |"Please fill up this field." |
                  | "John" | "john.doe+1example.com" | "Please include an '@' in the email address. 'this.me.dot.com' is missing a '@'." |

            @negative @validation @TC-04
            Scenario Outline: Validate missing mandatory fields shown error messages
            Given the shopper has initiated signup with valid name and email
            And the shopper is on the "ENTER ACCOUNT INFORMATION" page
            When the shopper tries to submit the form page leaving the "<field_to_skip>" field blank
            Then the shopper remains on the "ENTER ACCOUNT INFORMATION" page
            And an error message "Please fill up this field." should be displayed in the field "<field_to_skip>"

            Examples:
                  | field_to_skip |
                  | Password      |
                  | First Name    |
                  | Last Name     |
                  | Address       |
                  | Country       |
                  | State         |
                  | City          |
                  | Zipcode       |
                  | Mobile Number |

      Task: convert these site test cases into ONE .feature file:
      TC-02: Login User with correct email and password
      1. Launch browser
      2. Navigate to url 'http://automationexercise.com'
      3. Verify that home page is visible successfully
      4. Click on 'Signup / Login' button
      5. Verify 'Login to your account' is visible
      6. Enter correct email address and password
      7. Click 'login' button
      8. Verify that 'Logged in as username' is visible
      9. Click 'Delete Account' button
      10. Verify that 'ACCOUNT DELETED!' is visible

      TC-03: Login User with incorrect email and password
      1. Launch browser
      2. Navigate to url 'http://automationexercise.com'
      3. Verify that home page is visible successfully
      4. Click on 'Signup / Login' button
      5. Verify 'Login to your account' is visible
      6. Enter incorrect email address and password
      7. Click 'login' button
      8. Verify error 'Your email or password is incorrect!' is visible

      Test Case 4: Logout User
      1. Launch browser
      2. Navigate to url 'http://automationexercise.com'
      3. Verify that home page is visible successfully
      4. Click on 'Signup / Login' button
      5. Verify 'Login to your account' is visible
      6. Enter correct email address and password
      7. Click 'login' button
      8. Verify that 'Logged in as username' is visible
      9. Click 'Logout' button
      10. Verify that user is navigated to login page

      Output: the .feature content in /features/ui/, then (1) a list of assumptions you made  (messages, field names) that I must verify manually, and (2) two extra negative scenarios the source cases don't cover.