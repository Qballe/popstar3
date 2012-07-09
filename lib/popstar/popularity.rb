module Popstar
  module Popularity
    include Singleton
    
    def popularity_for(target, &block)
      RuleGroup.new(target, &block)
    end
  end
end