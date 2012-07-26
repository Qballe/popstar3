module Popstar
  class RuleGroup
    def initialize(target, &block)
      @target = target
      instance_eval(&block) if block_given?
    end

    def on(action, model, *args)
      options = args.extract_options!
      options.reverse_merge!(
        :rate => 1
      )

      rate = begin
        if options[:rate].respond_to?(:call)
          options[:rate]
        else
          proc { options[:rate] }
        end
      end

      target = @target

      if Popstar::Migration.rules[target].present?
        Popstar::Migration.rules[target] << { :action => action, :model => model, :rate => rate }
      else
        Popstar::Migration.rules[target] = [{ :action => action, :model => model, :rate => rate }]
      end

      increase_popularity = proc do |model|
        model.send(target).inc(:popularity, rate.call(model))
      end

      decrease_popularity = proc do |model|
        model.try(:send, target).try(:inc, :popularity, -rate.call(model))
      end

      model.send("after_#{action}", increase_popularity)
      model.send("after_destroy", decrease_popularity) if action == :create
    end
  end
end