# Popstar

Popularity system for your Rails models.

## Installation

Put this in your gemfile:

`gem 'popstar'`

Define your badge rules in a PopularityRules class

```
class PopularityRules
  def initialize
    popularity_for :voteable do
      on :create, Vote, :rate => proc { |vote| vote.rate*2 }
      on :update, Vote, :rate => proc { |vote| (vote.rate - vote.rate_was)*2 }
    end

    popularity_for :question do
      on :create, Answer, :rate => 2
    end

    popularity_for :viewable do
      on :create, ViewsCount
    end

    popularity_for :widget do
      on :create, Comment
      on :create, Question, :rate => 2
      on :create, Answer, :rate => 3
    end
  end
end
```