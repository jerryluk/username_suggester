module UsernameSuggester
  class Suggester

    attr_reader :first_name, :last_name

    # A Suggester class to suggest user_names
    #
    # ==== Parameters
    #
    # * <tt>:first_name</tt>  - Required.
    # * <tt>:last_name</tt>   - Required.
    # * <tt>:options</tt>     - See UsernameSuggester::SuggestionsFor
    #
    def initialize(first_name, last_name)
      raise Error, "first_name or last_name has not been specified" if first_name.nil? || last_name.nil?

      @first_name = first_name.downcase.gsub(/[^\w]/, '')
      @last_name  = last_name.downcase.gsub(/[^\w]/, '')
    end
    
    # Generates the combinations without the knowledge of what names are available
    def name_combinations
      @name_combinations ||= [
        "#{first_name}",
        "#{last_name}",
        "#{first_name[0]}#{last_name}",
        "#{first_name}#{last_name[0]}",
        "#{first_name}#{last_name}",
        "#{last_name[0]}#{first_name}",
        "#{last_name}#{first_name[0]}",
        "#{last_name}#{first_name}"
      ].uniq.reject { |s| s.blank? }
    end
    
    # Generates suggestions and making sure they are not in unavailable_suggestions
    def suggest(options)
      candidates_to_exclude = options[:exclude]
      validation_block      = options[:validate]
      number_of_suggestions = options[:num_suggestions]

      results    = []
      candidates = name_combinations.clone
      while results.size < number_of_suggestions && !candidates.blank?
        candidate = candidates.shift
        if validation_block.try(:call, candidate)
          # Don't add the candidate to result
        elsif candidates_to_exclude.include? candidate
          candidates << find_extended_candidate(candidate, candidates_to_exclude)
        else
          results << candidate
        end
      end

      results
    end
    
  private

    # Generates a candidate with "candidate<number>" which is not included in unavailable_set
    def find_extended_candidate(candidate, candidates_to_exclude)
      i = 1
      i+=rand(10) while candidates_to_exclude.include? "#{candidate}#{i}"
      "#{candidate}#{i}"
    end
  end
end