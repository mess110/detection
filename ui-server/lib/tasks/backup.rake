namespace :db do
  desc 'Save the production database to backup.psql'
  task :backup do
    system("pg_dump ui-server_production > backup.psql")
  end
end
