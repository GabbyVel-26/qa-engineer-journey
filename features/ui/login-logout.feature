# Source: automationexercise.com/test_cases, Test Case 2, 3 & 4
@ui @login
Feature: User login and logout
  As a registered shopper
  I want to log in and out of my account
  So that I can access my account securely

  Background:
    Given a registered test account is available
    And the shopper is on the login and signup page

  @smoke @TC-02
  Scenario: Log in with correct email and password
    When the shopper logs in with the configured test account's credentials
    Then the shopper should see the logged-in account name

  @negative @TC-03 @additional
  Scenario Outline: Fail login due to invalid credential combinations
    When the shopper attempts to log in with <credential_scenario>
    Then the error message "Your email or password is incorrect!" should be displayed

    Examples:
      |credential_scenario|
      |both an incorrect email and an incorrect password|
      |the valid test account email and an incorrect password|
      |an incorrect email and the valid test account password|

  @smoke @TC-04
  Scenario: Log out of an account
    Given the shopper is logged in with the configured test account
    When the shopper logs out
    Then the shopper should be redirected to the login page
