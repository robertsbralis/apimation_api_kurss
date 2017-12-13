require 'rest-client'
require 'test-unit'

def login_positive
  login_payload = { :login => @test_user.email,:password => @test_user.password}.to_json
  responce=post('https://www.apimation.com/login',
                headers: {'Content-Type'=>'application/json'},
                cookies: {},
                payload: login_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Login failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  assert_equal(@test_user.email, responce_hash['email'], 'Email in the responce in incorrent')
  assert_not_equal(nil, responce_hash['user_id'], 'User id is empty')
  assert_equal(@test_user.email, responce_hash['login'], 'Login in the responce in incorrent')
  @test_user.set_session_cookie(responce.cookies)
  @test_user.set_user_id(responce_hash['user_id'])
end

def check_personal_info
  responce = get('https://www.apimation.com/user',
                 headers:{},
                 cookies: @test_user.session_cookie)
  responce_hash = JSON.parse(responce)
  # Check if 200 OK is received
  assert_equal(200, responce.code, "Failed to fetch user! Response : \n #{responce}")
  # Check email if it is correct
  assert_equal(@test_user.email, responce_hash['email'], 'Email is incorrect')
  # Check user_id
  assert_equal(@test_user.user_id, responce_hash['user_id'], 'User_id is incorrect!')
  # Check session cookie
  assert_equal(@test_user.session_cookie['dancer.session'], responce_hash['sid'],'Session cookie is incorrect/session id is incorrect!')
end

def login_wrong_password
  login_payload = { :login => @test_user.email,:password => 'nepareizaParole'}.to_json
  responce = post('https://www.apimation.com/login',
                  headers: {'Content-Type'=>'application/json'},
                  cookies: {},
                  payload: login_payload)
  #Check if error 400 is received
  assert_equal(400, responce.code, "Wrong error code received! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if received error code is correct
  assert_equal('002',responce_hash['error-code'],'Error code in responce is not correct!')
  # Check if received error message is correct
  assert_equal('Username or password is not correct',responce_hash['error-msg'],'Error message is not correct!')
  @test_user.set_session_cookie(responce.cookies)
end

def check_user_not_logged
  responce = get('https://www.apimation.com/user',
                 headers:{},
                 cookies: @test_user.session_cookie)
  responce_hash=JSON.parse(responce)
  #Check if error 400 is received
  assert_equal(400, responce.code, "Wrong error code received! Responce: #{responce}")
  assert_equal('001',responce_hash['error-code'],'Error code in responce is not correct!')
  assert_equal('No session',responce_hash['error-msg'],'Error message is not correct!')
end