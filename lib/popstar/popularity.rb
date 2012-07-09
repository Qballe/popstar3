module Popstar
  module Popularity
    def self.included(base)
      base.send :include, Singleton
    end

    def popularity_for(target, &block)
      RuleGroup.new(target, &block)
    end
  end
end