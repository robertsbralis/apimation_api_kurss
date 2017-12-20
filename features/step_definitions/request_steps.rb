
Then(/^I set project active$/) do
  set_active_project
end
And(/^I create a collection with name: (.*)$/) do |collection_name|
  create_collection(collection_name)
end
Then(/^I create a request for login$/) do
  create_login_request
end