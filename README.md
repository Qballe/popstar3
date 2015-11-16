# Popstar3
Mongoid >= 3.0.0 support of [Popstar repo][lps]

____________________________________


Popularity system for your Rails models.

## Installation

Put this in your gemfile:

`gem 'popstar3'`

## Usage

Define your badge rules in a PopularityRules class

```
class PopularityRules
  include Popstar3::Popularity

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

## Supported ORMS

- Mongoid >= 3.0.0

## TODO

- Add support for ActiveRecord
- Add rake tasks to migrate popular models after defining rules


[lps]: <https://github.com/responsa/popstar>