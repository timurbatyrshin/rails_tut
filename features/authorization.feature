Feature: Authorization

Background:
  Given the user has an account


Scenario: Bail out non-signed users
  Given a user is not signed in
  When a user visits edit page
  Then he should see a signin page
  And he should see a notice message

Scenario: Protect from unauthenticated submit actions
  Given a user is not signed in
  When a user submits update form
  Then he should be redirected to a signin page

Scenario: Protect from editing of others info
  Given a user is signed in
  And a wrong user exists
  When a user visits edit page for wrong user
  Then he should not see edit page

Scenario: Protect from unauthorized submit actions
  Given a user is signed in
  And a wrong user exists
  When a user submits update form for wrong user
  Then he should be redirected to a root page

Scenario: Friendly forwarding
  When a user visits edit page
  And a user submits valid credentials
  Then he should see edit page

Scenario: Friendly forwarding persistence
  When a user visits edit page
  And a user submits valid credentials
  And he clicks the signout link
  And a user signs in
  Then he should see his profile page

Scenario: Signed in user should not be able to sign up again
  Given a user is signed in
  When a user visits signup page
  Then he should see his profile page

Scenario: Protect from signed in user submitting sign up again
  Given a user is signed in
  When a user submits a sign up
  Then he should be redirected to his profile page

Scenario: Not signed in users should not be able to create microposts
  Given a user is not signed in
  When users submits a micropost creation
  Then he should be redirected to a signin page
  And the micropost should not be created

Scenario: Not signed in users should not be able to delete microposts
  Given a user is not signed in
  And a micropost with content "Foo" exist
  When users submits a micropost deletion
  Then he should be redirected to a signin page
  And the micropost should not be deleted

Scenario: Not signed in users should not see the following page
  Given a user is not signed in
  When a user visits following page
  Then he should see a signin page

Scenario: Not signed in users should not see the followers page
  Given a user is not signed in
  When a user visits followers page
  Then he should see a signin page

Scenario: Not signed in users should not be able to follow
  Given a user is not signed in
  And another user has an account
  When users submits follow for another user
  Then he should be redirected to a signin page
  And the user should not follow another user

Scenario: Not signed in users should not be able to unfollow
  Given a user is not signed in
  And another user has an account
  And user follows another user
  When users submits unfollow for another user
  Then he should be redirected to a signin page
  And the user should follow another user
