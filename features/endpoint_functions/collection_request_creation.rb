def set_active_project

  responce = put('https://www.apimation.com/projects/active/'+@project_array.last.project_id,
                 headers: {'Content-Type'=>'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: {})
  # Check if correct 204 call is received
  assert_equal(204, responce.code,"Setting active project failed! Responce: #{responce}")
end

def create_collection(name)
  collection_payload={:description=>'',:name =>name}.to_json
  responce=post('https://www.apimation.com/collections',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: collection_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct name is sent in responce
  assert_equal(name.to_s,responce_hash['name'],"Creating collection failed! Responce: #{responce}")
  @collection_array.push(responce_hash)
end

def create_login_request
  request_name='login_case'
  steps_payload={:collection_id=>@collection_array.last['id'],
                 :description=>'',
                 :name=>request_name,
                 :paste=>false,
                 :request=>{:method=>'POST',
                            :url=>'https://www.apimation.com/login',
                            :type=>'raw',:body=>{},

                 },
                 :auth=>{:type=>'basicAuth',:data=>{:Username=>@test_user.email,:password=>@test_user.password}}}.to_json
  responce=post('https://www.apimation.com/steps',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: steps_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating request failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  # Check if correct collection
  assert_equal(@collection_array.last['id'],responce_hash['collection_id'],"Incorrect collection  returned! Responce: #{responce}")
  # Check if correct request name
  assert_equal(request_name,responce_hash['name'],"Incorrect request name returned! Responce: #{responce}")
  #Check if correct url is returned
  assert_equal(@collection_array.last['url'],'https://www.apimation.com/login',"Incorrect URL returned! Responce: #{responce}")

end