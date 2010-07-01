require File.dirname(__FILE__) + '/spec_helper'

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username
  suggestions_for :username
end

describe UsernameSuggester::UsernameSuggestions do
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
end