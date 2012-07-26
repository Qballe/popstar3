module Popstar
  class Migration
    def self.up
      @@rules.each do |target, rules|
        rules.each do |rule|
          if rule[:action] == :create
            rule[:model].send(target).inc(:popularity, rule[:rate])
          end
        end
      end
    end

    def self.rules
      @@rules || {}
    end

    def self.rules=(rules)
      @@rules ||= rules
    end
  end
end