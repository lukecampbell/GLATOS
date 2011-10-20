Feature: Sign in
  In order to get access to protected sections of the site
  As a user
  I want to be able to request an account

  Background:
    Given I am not logged in
    And no emails have been sent
    And I am on the home page
    And I go to the sign up page

  Scenario: User signs up with valid data
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
    And I press "Sign up"
    Then I should see "You have successfully requested an account"
    And "user@test.com" should receive 1 email
    When I open the email
    And I should see "Confirm my account" in the email body
    When I follow "Confirm my account" in the email
    Then I should see "Your account was successfully confirmed"
    And I should see "Your account has not been approved by an Administrator yet"

  Scenario: User signs up with invalid email
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | invalidemail    |
        | Password              | please          |
        | Password confirmation | please          |
    And I press "Sign up"
    Then I should see "Email is invalid"

  Scenario: User signs up without password
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              |                 |
        | Password confirmation | please          |
    And I press "Sign up"
    Then I should see "Password can't be blank"

  Scenario: User signs up without password confirmation
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation |                 |
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"

  Scenario: User signs up with mismatched password and confirmation
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please1         |
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"
