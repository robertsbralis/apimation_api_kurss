require 'rest-client'
require 'test-unit'

def create_project
  rand=Random.new
  project_name='Test'+rand.rand(0..1000).to_s
  @project_array.push(Project.new(project_name))
  creation_payload={:name =>project_name,:type =>'basic'}.to_json
  responce = post('https://www.apimation.com/projects',
                  headers: {'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie,
                  payload: creation_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Login failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  assert_equal(@project_array.last.name, responce_hash['name'], 'Name in the responce in incorrent!')
  assert_equal(@project_array.last.type, responce_hash['type'], 'Project type in the responce in incorrent')
  @project_array.last.set_project_id(responce_hash['id'])
end


def create_environment(env_name)
  environment_payload={:name =>env_name}.to_json
  responce=post('https://www.apimation.com/environments',
                headers: {'Content-Type'=>'application/json'},
                cookies: @test_user.session_cookie,
                payload: environment_payload)
  #Check if 200 OK is received
  assert_equal(200, responce.code,"Creating environment failed! Responce: #{responce}")
  responce_hash=JSON.parse(responce)
  @project_array.last.set_environments(env_name,responce_hash['id'])
  assert_equal(@project_array.last.environments.last['name'], responce_hash['name'], 'Name in the responce in incorrent!')
  assert_equal(@project_array.last.environments.last['id'], responce_hash['id'], 'Project id in the responce in incorrent')

end

def create_global_variable(name,value)
  @project_array.last.global_variables.push({'key'=>'$'+name,'value'=>value})
  variable_payload={:global_vars =>@project_array.last.global_variables}.to_json
  responce = put('https://www.apimation.com/environments/'+@project_array.last.environments.last['id'],
                 headers: {'Content-Type'=>'application/json'},
                 cookies: @test_user.session_cookie,
                 payload: variable_payload)
  #Check if 204 No Content (Successful request) is received
  assert_equal(204, responce.code,"Setting global var failed! Responce: #{responce}")
end

def delete_environment
  responce=delete('https://www.apimation.com/environments/'+@project_array.last.environments.last['id'],
                  headers:{'Content-Type'=>'application/json'},
                  cookies: @test_user.session_cookie)
  #Check if 204 No Content is received
  assert_equal(204, responce.code, "Creating environment failed! Responce: #{responce}")
  @project_array.last.environments.pop
end