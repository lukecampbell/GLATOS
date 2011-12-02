Feature: Request Account
  In order to get access to protected sections of the site
  As a user
  I want to be able to request an account

  Background:
    Given an admin user exists
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

  Scenario: General users do not require an approval
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
    And I choose "General"
    And I press "Sign up"
    Then "admin@test.com" should receive 0 emails
    And "user@test.com" should receive 1 email
    When I open the email
    And I should see "Confirm my account" in the email body
    When I follow "Confirm my account" in the email
    Then I should be signed in

  Scenario: Administrators receive an email about the new accounts that are not General
    And I fill in the following:
        | Name                  | Testy McUserton |
        | Email                 | user@test.com   |
        | Password              | please          |
        | Password confirmation | please          |
    And I choose "Investigator"
    And I press "Sign up"
    Then "admin@test.com" should receive 1 email
    When I open the email
    And I should see "A new account was requested on GLATOS Web" in the email body
    And I should see "Testy McUserton" in the email body
    Given I am logged in as an admin
    And I follow "User Administration" in the email
    Then I should be on the user admin page

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
