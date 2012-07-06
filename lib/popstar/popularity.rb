module Popstar
  module Popularity
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def popularity_for(target, &block)
        RuleGroup.new(target, &block)
      end
    end
  end
end