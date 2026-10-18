# Source: automationexercise.com/test_cases, Test Cases: 14, 15, 16, 23, 24, 14-N1, 14-N2, 14-N3, 14-E1
@ui @checkout
Feature: Checkout and Order Placement
  As a shopper
  I want to complete my purchase efficiently
  So that I can receive my ordered products and access my invoices

  Background:
    Given a shopper has items in their shopping cart

  # --- POSITIVE FLOWS (AUTHENTICATION & CHECKOUT) ---

  @smoke @TC-14
  Scenario: Place order by registering during checkout
    When the shopper registers for an account during the checkout process
    And the shopper completes the purchase
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  @smoke @TC-15
  Scenario: Place order as a newly registered shopper
    Given the shopper has just registered and logged in
    When the shopper completes the purchase
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  @smoke @TC-16
  Scenario: Place order as a returning shopper
    Given the shopper is logged into an existing account
    When the shopper completes the purchase
    Then the order should be successfully placed with the confirmation message "checkout.success_message"

  # --- VALIDATIONS & DATA INTEGRITY ---

  @smoke @validation @TC-23
  Scenario: Verify delivery and billing address matching during checkout
    Given the shopper has a profile with distinct delivery and billing addresses
    When the shopper views their checkout summary
    Then the displayed delivery and billing addresses should match their profile

  @smoke @TC-24
  Scenario: Download invoice after completing a purchase order
    Given the shopper has successfully placed an order
    When the shopper downloads their order invoice
    Then the downloaded invoice file should be valid file with accurate order details

  # --- NEGATIVE FLOWS ---

  @negative @TC-14-N1
  Scenario: Prevent proceeding to checkout when cart is empty
    Given the shopper has an emty shopping cart
    When the shopper attempts to checkout
    Then the shopper should be blocked on the cart page with a "checkout.empty_cart" error

  @negative @validation @TC-14-N2
  Scenario Outline: Validate missing payment fields during checkout order placement
    Given the shopper is logged and on the checkout payment page
    When the shopper attempts to pay with a blank "<field_to_skip>"
    Then the payment should be rejected with a "checkout.missing_field_validation" error

    Examples:
      | field_to_skip   |
      | Name on Card    |
      | Card Number     |
      | CVC             |
      | Expiration Month|
      | Expiration Year |

  @negative @validation @TC-14-N3
  Scenario Outline: Reject payment with invalid card structures
    Given the shopper is logged and on the checkout payment page
    When the shopper provides an invalid format "<invalid_value>" for the "<target_field>"
    Then the payment should be rejected with a "checkout.invalid_field_validation" error

    Examples:
      | target_field | invalid_value |
      | Card Number  | "ABCD-EFGH"   |
      | CVC          | "XYZ"         |

  # --- EDGE CASES ---

  @edge-case @TC-14-E1
  Scenario: Handle extreme data length inside the checkout confirmation comment area
    Given the shopper is logged and on the checkout summary page
    When the shopper submits a comment exceeding "10000" characters
    And the shopper completes the purchase
    Then the order invoice record should preserve the full text length
