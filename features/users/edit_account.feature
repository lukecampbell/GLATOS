Feature: Edit Account
  In order to change my details
  As a user
  I want to be able to edit my account

  Background:
    Given a admin user exists
    And an approved user exists
    And I am logged in as an approved user
    And I go to the edit account page
    And no emails have been sent

  Scenario: User can change their password
    When I fill in the following:
        | Password                   | changed         |
        | Password confirmation      | changed         |
        | Current Password           | please          |
    And I press "Update"
    When I sign in as "user@test.com/changed"
    Then I should be signed in

  Scenario: User can change their name
    When I fill in the following:
        | Name                       | New Name      |
        | Current Password           | please        |
    And I press "Update"
    Then a user should exist with name: "New Name"

  Scenario: User can change their email
    When I fill in the following:
        | Email                      | newemail@test.com |
        | Current Password           | please            |
    And I press "Update"
    Then a user should exist with email: "newemail@test.com"

  Scenario: User can not change their password if the new ones do not match
    When I fill in the following:
        | Password                   | changed         |
        | Password confirmation      | different       |
        | Current Password           | please          |
    And I press "Update"
    Then I should see "Password doesn't match confirmation"

  Scenario: User can request a role change
    When I fill in the following:
        | Current Password           | please          |
    And I choose "Investigator"
    And I press "Update"
    Then "admin@test.com" should receive 1 email
    When I open the email
    And I should see "A user is requesting an upgraded role" in the email body
    And I should see "Current Role: General" in the email body
    And I should see "Newly Requested Role: Investigator" in the email body
    Given I am logged in as an admin
    And I follow "User Administration" in the email
    Then I should be on the user admin page
