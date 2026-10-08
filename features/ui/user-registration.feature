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
    When the shopper signs up as "<new_name>" with "<unique_email>"
    And completes their account profile and address information with:
    |name| email | password   | first_name   | last_name   | address   | country   | state   | city   | zipcode   | mobile_number   |
    | <name> | <email> | <password> | <first_name> | <last_name> | <address> | <country> | <state> | <city> | <zipcode> | <mobile_number> |
    Then the account should be successfully created with the confirmation message "ACCOUNT CREATED!"

    Examples:
      |new_name|unique_email|name|email|password|first_name|last_name|address|country|state|city|zipcode|mobile_number|
      |"John"|"john.doe+1@example.com"|"John"|"john.doe+1@example.com"|"password"|"John"|"Doe"|"123 Main St"|"United States"|"California"|"Los Angeles"|"90210"|"1234567890"|

  @negative @TC-02
  Scenario: Register with an already registered email
    Given an account already exists for "john.doe+1@example.com"
    When the shopper attempts to sign up with "john.doe+1@example.com"
    Then an error message "Email Address already exist!" is displayed

  @negative @TC-03
  Scenario Outline: Register with empty required data
    When the shopper signs up with "<new_name>" and "<new_email>"
    Then an error message "<error_message>" is displayed
    And the shopper remains on the registration page

    Examples:
      | new_name | new_email | error_message |
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
