Feature: Create project/environments/global variables etc.

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

  Scenario: Create a request from existing project
    When I login in apimation as regular user
    Then I create a new apimation project
    Then I set project active
    And I create a collection with name: TESTAPI
    Then I create a request for login