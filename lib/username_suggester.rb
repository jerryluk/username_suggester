# UsernameSuggester
require "username_suggester/suggester"

if defined?(ActiveRecord)
  require "username_suggester/suggestions_for"
  ActiveRecord::Base.send :include, UsernameSuggester::UsernameSuggestions
end