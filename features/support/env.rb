Before() do
  puts "Before hook.This will work before every test case!"
  @test_user = User.new('bralisroberts@gmail.com','parole')
end