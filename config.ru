require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

web: bundle exec thin start -p $PORT
release: bundle exec rake db:migrate

use Rack::MethodOverride
use PortfoliosController
use UsersController
run ApplicationController
