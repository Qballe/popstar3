module Popstar
  class Migration
    @@rules = {}

    class << self
      def up
        @@rules.each do |target, rules|
          rules.each do |rule|
            if rule[:action] == :create
              rule[:model].all.each do |model|
                model.send(target).inc(:popularity, rule[:rate].call(model))
              end
            end
          end
        end
      end

      def rules
        @@rules || {}
      end

      def rules=(rules)
        @@rules ||= rules
      end
    end
  end
end