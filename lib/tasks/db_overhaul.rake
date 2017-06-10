namespace :db do
  desc 'overhaul'

  task overhaul: :environment do
    Rake::Task['db:migrate:reset'].invoke
    Rake::Task['db:seed'].invoke
  end
end
