namespace :popstar3 do
  desc "Migrates the database to new popularity rules"
  task :migrate => :environment do
    Popstar3::Migration.up
  end
end
