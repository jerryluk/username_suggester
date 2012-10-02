module UsernameSuggester
  module SuggestionsFor
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
      # <tt>:exclude</tt>: An array of strings that should not be suggested
      #
      def suggestions_for(attribute = :username, options = {})
        options[:first_name_attribute] ||= :first_name
        options[:last_name_attribute]  ||= :last_name
        options[:num_suggestions]      ||= 10
        options[:exclude]              ||= []
        
        define_method "#{attribute}_suggestions" do
          suggester = Suggester.new(send(options[:first_name_attribute]), send(options[:last_name_attribute]), options)

          t = self.class.arel_table
          unavailable_choices = options[:exclude] +
                                self.class.find_by_sql(t.project(t[attribute])
                                  .where(t[attribute].matches_any(suggester.name_combinations)).to_sql)
                                    .map(&attribute)

          suggester.suggest(unavailable_choices)
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, UsernameSuggester::SuggestionsFor