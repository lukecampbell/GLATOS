Feature: Sign in
  In order to get access to protected sections of the site
  A user
  Should be able to sign in

    Scenario: User is not signed up
      Given I am not logged in
      And no user exists with an email of "user@test.com"
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Invalid email or password."
      And I should be signed out

    Scenario: User enters wrong password
      Given I am not logged in
      And I am an approved_user
      When I go to the sign in page
      And I sign in as "user@test.com/wrongpassword"
      Then I should see "Invalid email or password."
      And I should be signed out

    Scenario: User signs in successfully but is not approved
      Given I am not logged in
      And I am an unapproved_user
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Your account has not been approved"
      And I should be signed out

    Scenario: User signs in successfully with an approved account
      Given I am not logged in
      And I am an approved_user
      When I go to the sign in page
      And I sign in as "user@test.com/please"
      Then I should see "Signed in successfully"
      And I should be signed in
      When I return next time
      Then I should be already signed in
