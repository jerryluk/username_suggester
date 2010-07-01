require File.dirname(__FILE__) + '/spec_helper'

describe UsernameSuggester::Suggester do  
  describe "name combinations" do
    it "returns combinations of first name and last name" do
      UsernameSuggester::Suggester.new("Jerry", "Luk").name_combinations.should == [
        "jerry",
        "luk",
        "jluk",
        "jerryl",
        "jerryluk",
        "ljerry",
        "lukj",
        "lukjerry"
      ]
    end

    it "returns first name and first name initial if last name is blank" do
      UsernameSuggester::Suggester.new("Jerry", "").name_combinations.should == [
        "jerry",
        "j"
      ]
    end

    it "returns last name and last name initial if first name is blank" do
      UsernameSuggester::Suggester.new("", "Luk").name_combinations.should == [
        "luk",
        "l"
      ]
    end

    it "returns empty array for blank first name and last name" do
      UsernameSuggester::Suggester.new("", "").name_combinations.should == []
    end
  end
  
  describe "name suggestions" do
    before(:each) do
      @suggester = UsernameSuggester::Suggester.new("Jerry", "Luk")
    end
    
    it "returns suggestions for names that are not in the unavailable suggestions" do
      @suggester.suggest(5, []).should == ["jerry", "luk", "jluk", "jerryl", "jerryluk"]
    end
    
    it "returns extended suggestions for names that are in the unavailable suggestions" do
      UsernameSuggester::Suggester.send(:define_method, :rand) { 1 }
      @suggester.suggest(10, ["jerry"]).should include "jerry1"
      @suggester.suggest(10, ["jerry", "jerry1"]).should include "jerry2"
      @suggester.suggest(10, ["jerry", "jerry1031"]).should include "jerry1"
    end
    
    it "should only returns suggestions passing the validate proc" do
      suggestions = UsernameSuggester::Suggester.new("Jerry", "Luk", 
        :validate => Proc.new { |s| s.length <= 5 }).suggest(10, [])
      suggestions.should include "jerry"
      suggestions.should_not include "jerryl"
    end
  end
end