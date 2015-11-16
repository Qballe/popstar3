require 'spec_helper'

describe Popstar3::Popularity do
  it "should create a rule group with the correct target" do
    Popstar3::RuleGroup.should_receive(:new).with(:question).once

    popular_class = Class.new do
      include Popstar3::Popularity
      def initialize
        popularity_for(:question) { }
      end
    end

    popular_class.instance
  end
end