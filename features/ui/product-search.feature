# Source: automationexercise.com/test_cases, Test Cases: 09, 20, 09-N1, 09-02
@ui @product-search
Feature: Product Search
  As a shopper
  I want to search for products using keywords
  So that I can quickly find and purchase specific items

  Background:
    Given the shopper is on the products page
    And the shopper is not signed in

    # --- POSITIVE FLOWS---

  @smoke @TC-09
  Scenario Outline: Search returns matching products
    When the shopper searches the catalog for "<search_keyword>"
    Then only products matching "<search_keyword>" should be displayed

    Examples:
      | search_keyword |
      | Dress          |
      | T-shirt        |
      | Jeans         |

  @smoke @TC-20
  Scenario: Search cart persists after login
    Given the shopper has added matching items from a search for "Dress" to the cart
    When the shopper logs in with a registered test account
    Then the authenticated cart should retain the items added from the search results

    # --- NEGATIVE FLOWS ---

  @smoke @TC-09-N1
  Scenario: Search with a non-existent keyword
    When the shopper searches the catalog for "NonExistentProduct"
    Then the shopper should be notified that no matching products were found

  @smoke @TC-09-N2
  Scenario: Search with empty query
    When the shopper attempts to search with an empty search
    Then the catalog display should remain unfiltered
