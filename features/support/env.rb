Before() do
  puts "Before hook.This will work before every test case!"
  @test_user = User.new('bralisroberts@gmail.com','parole')
  @project_array=[]
end
After() do
  puts 'This happens after a test'
end