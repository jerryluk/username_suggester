require 'set'

module UsernameSuggester
  class Suggester
    attr_reader :first_name
    attr_reader :last_name
    
    # Creates a UsernameSuggester to suggest usernames
    #
    # ==== Parameters
    #
    # * <tt>:first_name</tt> - Required. 
    # * <tt>:last_name</tt> - Required. 
    # * <tt>:options</tt> - There is one option -- :validate. You can pass in a Proc object and the suggestion will
    #   be returned if involving the Proc with the suggestion returns true
    #
    def initialize(first_name, last_name, options = {})
      @first_name = (first_name || "").downcase
      @last_name = (last_name || "").downcase
      @options = options
    end
    
    # Generates the combinations without the knowledge of what names are available
    def name_combinations
      @name_combinations ||= [
        "#{@first_name}",
        "#{@last_name}",
        "#{@first_name.first}#{@last_name}",
        "#{@first_name}#{@last_name.first}",
        "#{@first_name}#{@last_name}",
        "#{@last_name.first}#{@first_name}",
        "#{@last_name}#{@first_name.first}",
        "#{@last_name}#{@first_name}"
      ].uniq.reject { |s| s.blank? }
    end
    
    # Generates suggestions and making sure they are not in unavailable_suggestions
    def suggest(max_num_suggestion, unavailable_suggestions = [])
      unavailable_set = unavailable_suggestions.to_set
      results = []
      candidates = name_combinations.clone
      while results.size < max_num_suggestion and !candidates.blank?
        candidate = candidates.shift
        if @options[:validate] and !@options[:validate].call(candidate)
          # Do nothing
        elsif unavailable_set.include? candidate
          candidates << find_extended_candidate(candidate, unavailable_set)
        else
          results << candidate
        end
      end
      results
    end
    
  private
    # Generates a candidate with "candidate<number>" which is not included in unavailable_set
    def find_extended_candidate(candidate, unavailable_set)
      i = 1
      i+=1 while unavailable_set.include? "#{candidate}#{i}"
      "#{candidate}#{i}"
    end
  end
end