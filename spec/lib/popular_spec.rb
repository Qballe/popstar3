require 'spec_helper'

describe Popstar3::Popular do
  it "should add a popularity field to a model" do
    model_class = Class.new do
      include Mongoid::Document
      include Popstar3::Popular
    end

    model_class.should have_field(:popularity).of_type(Integer).with_default_value_of(0)
  end
end