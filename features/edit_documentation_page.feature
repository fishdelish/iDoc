Feature:
  In order to build useful documentation
  As a Document Author
  I need to edit existing documentation

  Scenario: Edit an existing documentation page as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I follow "Edit page"
    And I change the document title to "A page"
    And I press "Save changes"
    Then I should be on the document page for "A page"
    And I should see the new title
    And I should see "Page successfully updated"
    And I should see the page body

  Scenario: Attempt to remove the title from an existing documentation page as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I follow "Edit page"
    And I remove the document title
    And I press "Save changes"
    Then I should be on the document page
    And I should see "Title can't be blank"

  Scenario: Edit an existing documentation page as an unidentified user
    Given I am not identified
    And I have created a page
    When I go to the document page
    Then I should not see "Edit page"
    When I go to the edit document page
    Then I should be on the account logon page
    And I should see "You must be logged in to access this area"