require "spec_helper"

describe UsernameSuggester::SuggestionsFor do

  with_model :User do
    # The table block works just like a migration.
    table do |t|
      t.string :first_name, :last_name, :username
      t.timestamps
    end

    # The model block works just like the class definition.
    model do
      suggestions_for :username
    end
  end

  before(:each) do
    @user = User.new(:first_name => "Jerry", :last_name => "Luk")
  end
  
  it "should able to suggest usernames" do
    suggestions = @user.username_suggestions
    suggestions.should_not be_blank
    suggestions.should include "jerry"
  end
  
  it "should able to suggest usernames that are not taken" do
    UsernameSuggester::Suggester.send(:define_method, :rand) { 1 }
    
    User.create!(:username => "jerry")
    1.upto(10) do |i|
      User.create!(:username => "jerry#{i}")
    end
    suggestions = @user.username_suggestions
    suggestions.should_not be_blank
    suggestions.should_not include "jerry"
    suggestions.should include "jerry11"
  end
  
  it "should not suggest usernames in the exclusion list" do
    UsernameSuggester::Suggester.send(:define_method, :rand) { 1 }

    suggestions = @user.username_suggestions
    suggestions.should_not be_blank
    suggestions.should_not include "luk"
  end
  
end