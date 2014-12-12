namespace :refresh do

  desc "Replace local database and uploads from production"
  task :development do
    invoke 'refresh:development_database'
    invoke 'refresh:development_uploads'
  end

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
        execute :mysqldump, "-u #{@db['username']} --password=#{@env['harmanpro_database_password']} #{@db['database']} > #{@filename}"
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
        execute :rm, filename

        rake 'db:migrate'
      end
    end
  end

  desc "Replace contents of public/system from remote server"
  task :development_uploads do
    on roles(:web) do |host|
      set :upload_host, host
      set :upload_user, host.user
    end

    run_locally do
      execute :rsync, "-avz #{fetch(:upload_user)}@#{fetch(:upload_host)}:#{ shared_path }/public/system ./public/"
    end
  end
end