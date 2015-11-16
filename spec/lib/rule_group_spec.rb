require 'spec_helper'

describe Popstar3::RuleGroup do
  before(:each) do
    [:DummyQuestion, :DummyVote, :DummyComment].each do |model_class|
      Object.send(:remove_const, model_class) if Object.const_defined?(model_class)
    end

    class DummyQuestion
      include Mongoid::Document
      include Popstar3::Popular

      has_many :votes, :class_name => 'DummyVote', :inverse_of => :question
    end

    class DummyVote
      include Mongoid::Document

      belongs_to :question, :class_name => 'DummyQuestion', :inverse_of => :votes
      belongs_to :comment, :class_name => 'DummyComment', :inverse_of => :votes
    end

    class DummyComment
      include Mongoid::Document
      include Popstar3::Popular

      has_many :votes, :class_name => 'DummyVote', :inverse_of => :comment
    end
  end

  let(:group) { Popstar3::RuleGroup.new(:question) }
  let(:question) { DummyQuestion.create! }
  let(:comment) { DummyComment.create! }

  it "should call the block associated to a group" do
    block_group = nil

    test_group = Popstar3::RuleGroup.new(:question) do
      block_group = self
    end

    block_group.should be(test_group)
  end

  it "should update the popularity of the target by the default rate" do
    group.on(:create, DummyVote)
    lambda { question.votes.create! }.should change(question, :popularity).by(1)
  end

  it "should update the popularity of the target by a custom rate" do
    group.on(:create, DummyVote, :rate => 5)
    lambda { question.votes.create! }.should change(question, :popularity).by(5)
  end

  it "should update the popularity of the target by a proc" do
    group.on(:create, DummyVote, :rate => proc { |vote| vote.some_field })

    lambda do
      vote = question.votes.build
      vote.stub(:some_field).and_return(3)
      vote.save!
    end.should change(question, :popularity).by(3)
  end

  it "should decrease the popularity of the target by the rate" do
    group.on(:create, DummyVote)
    vote = question.votes.create!
    lambda { vote.destroy }.should change(question, :popularity).by(-1)
  end
end