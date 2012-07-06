module Popstar
  module Popularity
    def popularity_for(target, &block)
      RuleGroup.new(target, &block)
    end
  end
end