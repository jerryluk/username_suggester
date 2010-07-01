module UsernameSuggester
  module UsernameSuggestions
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      # Creates method to generate suggestions for an username attributes. Example:
      #
      #   suggestions_for :username, :num_suggestions => 5, 
      #     :first_name_attribute => :first, :last_name_attribute => last
      #
      # will creates a "username_suggestions" method which generates suggestions of usernames based on first name
      # and last name
      #
      # Available options are:
      # <tt>:attribute</tt>:: The name of the attribute for storing username. Default is <tt>:username</tt>
      # <tt>:first_name_attribute</tt>:: The attribute which stores the first name. Default is <tt>:first_name</tt>
      # <tt>:last_name_attribute</tt>:: The attribute which stores the last name. Default is <tt>:last_name</tt>
      # <tt>:num_suggestions</tt>:: Maximum suggestions generated. Default is <tt>10</tt>
      # <tt>:validate</tt>: An Proc object which takes in an username and return true if this is an validate username
      #
      def suggestions_for(attribute = :username, options = {})        
        first_name_attribute = options[:first_name_attribute] || :first_name
        last_name_attribute = options[:last_name_attribute] || :last_name
        num_suggestions = options[:num_suggestions] || 10
        
        send :define_method, "#{attribute}_suggestions".to_sym do
          suggester = Suggester.new(send(first_name_attribute), send(last_name_attribute), options)
          name_combinations_with_regex = suggester.name_combinations.map { |s| "^#{s}[0-9]*$" }
          sql_conditions = Array.new(name_combinations_with_regex.size, "#{attribute} RLIKE ?").join(" OR ")
          unavailable_choices = self.class.all(:select => attribute, 
            :conditions => [sql_conditions].concat(name_combinations_with_regex)).map{ |c| c.send(attribute) }
          suggester.suggest(num_suggestions, unavailable_choices)
        end
      end
    end
  end
end