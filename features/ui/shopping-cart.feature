# Source: automationexercise.com/test_cases, Test case 11, 12, 13, 17, 20, 22
@ui @cart
Feature: Shopping Cart Management
 As a shopper
 I want to manage items in my shopping cart
 So that I can review, update, and prepare my items for purchase

  Background:
    Given the shopper is on the home page

  @smoke @TC-11
  Scenario: Verify subscription in Cart page
    When the shopper navigates to the cart page
    And the shopper subscribes with configured test email in the footer
    Then a success message "You have been successfully subscribed!" should be displayed

  @smoke @TC-12
  Scenario Outline: Add products to the cart and verify totals
    Given the shopper navigates to the products page
    When the shopper adds the product "<product_one>" to the cart
    And continues shopping
    And the shopper adds the product "<product_two>" to the cart
    And reviews the cart
    Then both products should be visible in the cart
    And the respective prices, quantities, and totals should match the product catalog

    Examples:
      | product_one        | product_two       |
      | Blue Top           | Men Tshirt        |

  @smoke @TC-13
  Scenario Outline: Verify exact product quantity details in the cart
    Given the shopper views the product details for "<product>"
    When the shopper increases the order quantity to <target_quantity>
    And adds the product to the cart
    And reviews the cart
    Then the product should be displayed in the cart with the exact quantity <target_quantity>

    Examples:
      | product | target_quantity |
      | Blue Top | 4              |

  @smoke @TC-17
  Scenario Outline: Remove products from the cart
    Given the shopper has added "<product>" to the cart
    And the shopper navigates to the cart page
    When the shopper removes "<product>" from the cart
    Then the product "<product>" should no longer be visible in the cart

    Examples:
      | product            |
      | Blue Top           |

  @smoke @TC-20
  Scenario Outline: Search products and verify persistence in cart after logging in
    Given there is a configured test account's credential
    And the shopper navigates to the products page
    When the shopper searches for "<search_keyword>"
    And adds the matching product results to the cart
    And reviews the cart to confirm items are visible
    And logs in with a valid configured test account
    And returns to the cart page
    Then the previously added products should still be persistent and visible in the cart

    Examples:
      | search_keyword     |
      | Tshirt             |

  @smoke @TC-22
  Scenario Outline: Add to cart from recommended items
    Given the shopper is at the bottom of the home page where recommendations are shown
    When the shopper adds the recommended product "<recommended_product>" to the cart
    And reviews the cart
    Then the recommended product "<recommended_product>" should be displayed in the cart page

    Examples:
      | recommended_product |
      | Winter Top          |

  @negative @edge_case
  Scenario Outline: Attempt to update cart product quantity to invalid or zero inputs
    Given the shopper has viewed the "<product>"
    When the shopper modifies the quantity field for "<product>" to <invalid_quantity>
    And attempts to add the product to the cart
    Then the operation should be rejected
    And the quantity value should automatically revert or prompt an alert message

    Examples:

      | product  | invalid_quantity |
      | Blue Top | 0                |
      | Blue Top | -1               |
      | Blue Top | abc              |

  @negative @edge_case
  Scenario: Retain items when attempting to clear an empty shopping cart
    Given the shopper navigates to the cart page
    And the shopping cart contains no items
    When the shopper inspects the cart contents
    Then an empty cart container message "Cart is empty!" should be displayed
    And the checkout progression buttons should not be displayed
