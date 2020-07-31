require_relative './database'

if ENV['RACK_ENV'] == 'test'
  p 'Starting test database..'
  DatabaseConnection.setup('bookmark_manager_test')
else
  p 'Starting main database..'
  DatabaseConnection.setup('bookmark_manager')
end
