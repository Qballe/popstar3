require 'spec_helper'

describe Popstar::Popularity do
  it "should create a rule group with the correct target" do
    Popstar::RuleGroup.should_receive(:new).with(:question).once

    popular_class = Class.new do
      include Popstar::Popularity
      def initialize
        popularity_for(:question) { }
      end
    end

    popular_class.instance
  end
end