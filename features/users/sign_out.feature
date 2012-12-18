Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

    Scenario: User signs out
      Given an approved user has an account
      When I sign in as "user@test.com/please"
      Then I should be signed in
      And I sign out
      Then I should see "Signed out"
      When I return next time
      Then I should be signed out
