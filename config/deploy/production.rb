# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server 'rackspace1', user: 'hpro', roles: %w{admin web app}
#server 'rackspace2019', user: 'hpro', roles: %w{admin web app}
#server 'rackspace2020', user: 'hpro', roles: %w{admin web app db}, primary: true
server 'rackspace2021', user: 'hpro', roles: %w{admin web app db}, primary: true
set :branch, "bb31efef0a46096f4a51b5d48ca02ff97dfcf88d"
namespace :deploy do

#  before :restart, :refresh_node2_uploads do
#    invoke "refresh:node2_uploads"
#  end

end

set :thinking_sphinx_roles, :app
before "deploy:restart", "thinking_sphinx:configure"

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
