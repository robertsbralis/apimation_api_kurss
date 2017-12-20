class Project
  attr_accessor :name
  attr_accessor :environments
  attr_accessor :global_variables
  attr_accessor :project_id
  attr_accessor :type

  def initialize(name)
    @name=name
    @type='basic'
    @environments=[]
    @global_variables = []
  end

  def set_environments(env,id)
    hash={'name'=>env,'id'=>id}
    @environments = @environments.push(hash)
  end

  def set_project_id(id)
    @project_id=id
  end
end