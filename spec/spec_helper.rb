require 'active_record'
require 'with_model'

# At last require our lib
require 'username_suggester'

RSpec.configure do |config|
  config.extend WithModel
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")