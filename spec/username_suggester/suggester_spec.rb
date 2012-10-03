require File.dirname(__FILE__) + '/../spec_helper'

describe UsernameSuggester::Suggester do  
  describe "name combinations" do
    it "returns default combinations of first name and last name" do
      UsernameSuggester::Suggester.new("Jerry", "Luk").name_combinations
        .should eq(%w{jerry luk jluk jerryl jerryluk ljerry lukj lukjerry})
    end

    it "returns first name and first name initial if last name is blank" do
      UsernameSuggester::Suggester.new("Jerry", "").name_combinations.should eq(%w{jerry j})
    end

    it "returns last name and last name initial if first name is blank" do
      UsernameSuggester::Suggester.new("", "Luk").name_combinations.should eq(%w{luk l})
    end

    it "returns empty array for blank first name and last name" do
      UsernameSuggester::Suggester.new("", "").name_combinations.should eq([])
    end
    
    it "should not contain space even there is a space in names" do
      UsernameSuggester::Suggester.new("Ting Ting", "").name_combinations.should eq(%w{tingting t})
    end

  end

  describe "name suggestions options testing" do
    before(:each) do
      @suggester = UsernameSuggester::Suggester.new("Jerry", "Luk")
      @options   = { :exclude => [], :num_suggestions => 10 }
    end

    it "return all available suggestions if no exclusions passed" do
      @suggester.suggest(@options).should eq(%w{jerry luk jluk jerryl jerryluk ljerry lukj lukjerry})
    end

    it "return only first 3 suggestions" do
      @options[:num_suggestions] = 3
      @suggester.suggest(@options).should eq(%w{jerry luk jluk})
    end

    it "return suggestions but exclude the ones passed" do
      @options[:exclude] = ["jerry", "lukjerry"]
      @suggester.suggest(@options).should_not include("jerry", "lukjerry")
    end

    it "return alternative when excluded" do
      @options[:exclude] = ["jerry"]
      @suggester.suggest(@options).should include("jerry1")
    end

    it "filter out candidates using a proc block aka validation" do
      # Remove all suggestions starting with j
      @options[:validate] = proc { |s| s =~ /^j/ }
      @suggester.suggest(@options).should eq(%w{luk ljerry lukj lukjerry})
    end
  end

end