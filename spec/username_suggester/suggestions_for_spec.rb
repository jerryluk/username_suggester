require "spec_helper"

describe UsernameSuggester::SuggestionsFor do

  describe "default options given" do

    with_model :User do
      # User table migration
      table do |t|
        t.string :first_name, :last_name, :username
        t.timestamps
      end

      # Lets test suggestions_for without any options
      # By default there's nothing to exclude and number of suggestions equals 5
      model do
        suggestions_for :username
      end
    end

    before(:each) do
      @user = User.create(:first_name => "Jerry", :last_name => "Luk")
    end

    it "should be able to suggest usernames" do
      @user.username_suggestions.should eq(%w{jerry luk jluk jerryl jerryluk})
    end

    it "should suggest usernames that are not taken" do
      # Ooops some user stolen our "jerry" username, so we'll not showing it in suggestions array
      another_user = User.create(:first_name => "Robo", :last_name => "Cop", :username => "jerry")
      @user.username_suggestions.should_not include("jerry")

      # But is should include some alternative
      @user.username_suggestions.should_not include("jerry1")
    end

  end

  describe "complex options given" do

    with_model :User do
      # User table migration
      table do |t|
        t.string :first, :last, :login_name
        t.timestamps
      end

      model do
        suggestions_for :login_name, :first_name_attribute => :first,
                                     :last_name_attribute  => :last,
                                     :num_suggestions      => 3,
                                     :exclude              => ["reserved"],
                                     :validate             => proc { |s| s =~ /admin/ }
      end
    end

    before(:each) do
      @user = User.create(:first => "Reserved", :last => "Luk Admin")
    end

    it "should exclude 'reserved' from the list of suggestions" do
      @user.login_name_suggestions.should_not include("reserved")
      @user.login_name_suggestions.size.should eq(3)
    end

    it "should suggest usernames that are taken by me" do
      # Even if I have already this username it should suggest me the same cuz it's mine
      @user.login_name = "reservedl"
      @user.save
      @user.login_name_suggestions.should include("reservedl")
    end

  end
  
end