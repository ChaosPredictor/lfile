# lib/tasks/db_pull.rake
namespace :db do
  desc 'Pull production db to development'
  task :pull => [:dump, :restore]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'PG_DUMP on production database...'
    production = Rails.application.config.database_configuration['production']
    system "ssh deploy@178.62.26.95 -p 2505 'PGPASSWORD=\"#{production['password']}\" pg_dump -U lfile #{production['database']} -h #{production['host']} -F t' > #{dumpfile}"
    #system "ssh deploy@178.62.26.95 -p 2505 'PGPASSWORD=\"#{production['password']}\" pg_dump -U postgres #{production['database']} -h #{production['host']} -F t' > #{dumpfile}"
    puts 'Done!'
  end

  task :restore do
    dev = Rails.application.config.database_configuration['development']
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'PG_RESTORE on development database...'
    system "pg_restore --verbose --clean --no-acl --no-owner -h 127.0.0.1 -U #{dev['username']} -d #{dev['database']} #{dumpfile}"
    puts 'Done!'
  end
end
