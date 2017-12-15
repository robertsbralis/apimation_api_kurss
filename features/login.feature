Feature: Login feature
  Test login functionality of apimation.com

  Scenario: Login - positive
    When I login in apimation as regular user
    Then I check if I am logged in and I can access my personal information
  Scenario: Login - negative
    When I try to login apimation.com with a wrong password
    Then I check if I am not logged in and I cannot access my personal data

  Scenario: Create a test project and add 2 environments,add 2 global variables
    When I login in apimation as regular user
    Then I create a new apimation project
    And I create an environment called DEV
    Then I create an global variable called test1 with value 4
    And I create an global variable called test2 with value 3
    And I delete the environment
    And I create an environment called PROD
    Then I create an global variable called test1 with value 4
    And I create an global variable called test2 with value 3
    And I delete the environment