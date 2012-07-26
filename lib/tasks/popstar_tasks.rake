namespace :popstar do
  desc "Migrates the database to new popularity rules"
  task :migrate => :environment do
    Popstar::Migration.up
  end
end
