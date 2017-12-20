Then(/^I create a new apimation project$/) do
  create_project
end
Then(/^I create an environment called (.*)$/) do |environment|
  create_environment(environment)
end
And(/^I create an global variable called (.*) with value (.*)$/) do |variable_name,value|
  create_global_variable(variable_name,value)
end
Then(/^I delete the environment$/) do
  delete_environment
end