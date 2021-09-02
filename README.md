# ClosestTimes

This gem takes an array of elements, groups them by their ordered closest neighbors into `n` groups.

**Origin Story:**

Friend:

> "here's another one for you"
>
> "I have an array of DateTime objects, I want to match them up into groups of 4 that are the closest to each other"

Me:

> _\*That's an interesting problem. Maybe put this in a little gem\*_

Later that night

Me:

> "Here is what I have so far..."

The algorithm to determine the closest naighbour is to look at the element before and after to determine which one is closer.

E.g.
Given the sequence
```plain
input:        1   5    20
               \ / \  /
seperated by:   4   14
```
`1` and `5` (seperated by 4) are closer together than `5` and `20` (seperated by 14), so `5` is grouped with `1`

**groups:** 
1. `1`, `5`
2. `20`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'closest_times'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install closest_times
```

## Usage

Require the gem

```ruby
require 'closest_times'
```

Call the `ClosestTimes::Times` class

```ruby
ClosestTimes::Times.new(2, [1, 2, 3, 4]).call
# => [[1, 2], [3, 4]]
ClosestTimes::Times.new(3, [10.days.ago, 9.days.ago, 1.day.ago]).call
# => [[10.days.ago, 9.days.ago], [1.day.ago]]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec guard` to run tests when a file changes.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

To experiment with that code, run `bin/console` for an interactive prompt.

Bug reports and pull requests are welcome on GitHub at <https://github.com/aussidavid/closest_times>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ClosestTimes project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/closest_times/blob/master/CODE_OF_CONDUCT.md).
