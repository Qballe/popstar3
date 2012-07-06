module Popstar
  module Popular
    def self.included(base)
      base.field :popularity, :type => Integer, :default => 0
    end
  end
end