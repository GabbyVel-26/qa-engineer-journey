# Source: automationexercise.com/test_cases, Test Cases: 14, 15, 16, 23, 24, 14-N1, 14-N2, 14-N3, 14-E1
@ui @checkout
Feature: Checkout and Order Placement
  As a shopper
  I want to complete my purchase efficiently
  So that I can receive my ordered products and access my invoices

  # --- POSITIVE FLOWS (AUTHENTICATION & CHECKOUT) ---

  @smoke @TC-14
  Scenario: Place an order after registering during checkout
    Given the shopper has items in their cart
    When the shopper registers for an account during the checkout process
    And places their order
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  @smoke @TC-15
  Scenario: Place an order as a newly registered shopper
    Given the shopper has just registered
    And has items in their cart
    When the shopper proceeds to checkout
    And places their order
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  @smoke @TC-16
  Scenario: Place order as a returning shopper
    Given the shopper is signed in
    And has items in their cart
    When the shopper proceeds to checkout
    And the shopper places the order
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  # --- VALIDATIONS & DATA INTEGRITY ---

  @smoke @validation @TC-23
  Scenario: Verify delivery and billing address matching during checkout
    Given the shopper has a profile with distinct delivery and billing addresses
    And the shopper has items in their cart
    When the shopper proceeds to checkout
    Then the displayed delivery and billing addresses should match their profile

  @smoke @TC-24
  Scenario: Download invoice after completing a purchase order
    Given the shopper has successfully placed an order
    When the shopper downloads their order invoice
    Then the downloaded invoice file should be a valid file with accurate order details

  # --- NEGATIVE FLOWS ---

  @negative @TC-14-N1
  Scenario: Block checkout when the cart is empty
    Given the shopper is signed in
    And has an empty shopping cart
    When the shopper attempts to checkout
    Then the checkout should be blocked with a "checkout.empty_cart" error

  @negative @validation @TC-14-N2
  Scenario Outline: Reject payment when required card details are missing
    Given the shopper is on the payment page
    When the shopper submits payment with a blank "<card_detail>"
    Then the payment should be rejected with a "checkout.missing_field_validation" error

    Examples:
      | card_detail   |
      | Name on Card    |
      | Card Number     |
      | CVC             |
      | Expiration Month|
      | Expiration Year |

  @negative @validation @TC-14-N3
  Scenario Outline: Reject payment when card details do not meet validation
    Given the shopper is on the payment page
    When the shopper submits payment with an invalid "<card_detail>" value of "<invalid_value>"
    Then the payment should be rejected with a "checkout.invalid_field_validation" error
    And the shopper should be prompted to correct the "<card_detail>" field

    Examples:
      | card_detail | invalid_value |
      | Card Number  | ABCD-EFGH   |
      | Card Number  | 123           |
      | CVC          | XYZ         |
      | CVC          | 12            |
      | CVC          | 12345         |
      | Expiration Month | 00           |
      | Expiration Month | 13           |

  # --- EDGE CASES ---

  @edge-case @TC-14-E1
  Scenario: Handle extreme data length inside the checkout confirmation comment area
    Given the shopper is on the checkout summary page
    When the shopper submits a comment exceeding "10000" characters
    And the shopper completes the purchase
    Then the order invoice record should preserve the full text length
