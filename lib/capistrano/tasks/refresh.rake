namespace :refresh do

  # For staging:
  #
  # cap staging refresh:staging
	desc "Refresh the staging database and uploads from production"
	task :staging do
		invoke 'refresh:staging_database'
		invoke 'refresh:staging_uploads'
	end

  desc "Replace local database and uploads from production"
  task :development do
    invoke 'refresh:development_database'
    invoke 'refresh:development_uploads'
  end

  # Pass in keep_db to keep the database dump received from the server on your
  # local machine:
  #
  #   cap production refresh:development_database keep_db=true
  #
  desc "Replace the local development database with the contents of the production database"
  task :development_database do
    set :timestamp, Time.now.to_i

    on roles(:db) do
      @timestamp = fetch(:timestamp)

      within shared_path do
        @db = YAML::load(ERB.new(IO.read(File.join("config", "database.yml"))).result)['production']
        @env = YAML::load(ERB.new(IO.read(File.join("config", 'application.yml'))).result)['production']
      end

      @filename = "#{@db['database']}_#{@timestamp}.sql"
      folder = "db_backup"
      execute :mkdir, "-p", folder

      within folder do
        execute :mysqldump, "-u #{@db['username']} --password=#{@env['harmanpro_database_password']} -h #{@db['host']} --port=#{@db['port']} #{@db['database']} > #{@filename}"
        curr = capture(:pwd)
        download! "#{curr}/#{@filename}", "./#{@filename}"
        execute :rm, @filename
      end
    end

    run_locally do
      with rails_env: :development do
        @timestamp = fetch(:timestamp)

        db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), "../../../config", "database.yml"))).result)
        prd_db = db['production']
        dev_db = db['development']
        filename = "#{prd_db['database']}_#{@timestamp}.sql"

        rake 'db:drop'
        rake 'db:create'

        execute :mysql, "-u #{dev_db['username']} #{dev_db['database']} < ./#{filename}"
        unless ENV['keep_db'] == "true"
          execute :rm, filename
        end

        rake 'db:migrate'
      end
    end
  end

  desc "Replace contents of public/system from remote server"
  task :development_uploads do
    on roles(:admin) do |host|
      set :upload_host, host
      set :upload_user, host.user
    end

    run_locally do
      execute :rsync, "-avz #{fetch(:upload_user)}@#{fetch(:upload_host)}:#{ shared_path }/public/system ./public/"
    end
  end

  # It would be nice to rsync directly between the two servers, but the
  # internal server can't communicate out. Genius.
  desc "Refreshes local public/system and then pushes the same to production node2"
  task :node2_uploads do
    invoke 'refresh:development_uploads'

    on roles(:node2) do |host|
      set :upload_host, host
      set :upload_user, host.user
    end

    run_locally do
      execute :rsync, "-avz ./public/system #{fetch(:upload_user)}@#{fetch(:upload_host)}:#{ shared_path }/public/"
    end
  end

  desc "Replace the remote staging database with the contents of the production database"
  task :staging_database do
    set :timestamp, Time.now.to_i

    on roles(:db) do

      with rails_env: :staging do
        within shared_path do
          @db = YAML::load(ERB.new(IO.read(File.join("config", "database.yml"))).result)
        end

        within release_path do
          rake 'db:drop'
          rake 'db:create'

          execute :mysqldump, "-u #{@db['production']['username']} --password=#{@db['production']['password']} -h #{@db['production']['host']} --port=#{@db['production']['port']} #{@db['production']['database']} | mysql -u #{@db['staging']['username']} --password=#{@db['staging']['password']} #{@db['staging']['database']}"

          rake 'db:migrate'
        end
      end
    end
  end

  # It would be nice to rsync directly between the two servers, but the
  # internal server can't communicate out. Genius.
  desc "Refreshes local public/system and then pushes the same to staging"
  task :staging_uploads do
    invoke 'refresh:development_uploads'

    on roles(:web) do |host|
      set :upload_host, host
      set :upload_user, host.user
    end

    run_locally do
      execute :rsync, "-avz ./public/system #{fetch(:upload_user)}@#{fetch(:upload_host)}:#{ shared_path }/public/"
    end
  end
end
