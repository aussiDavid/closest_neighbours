# ClosestNeighbours

[![Gem Version](https://badge.fury.io/rb/closest_neighbours.svg)](https://badge.fury.io/rb/closest_neighbours)
[![Build Status](https://app.travis-ci.com/aussiDavid/closest_neighbours.svg?branch=main)](https://app.travis-ci.com/aussiDavid/closest_neighbours)

This gem takes an array of elements, groups them by their ordered closest neighbors into `n` groups.

**Origin Story:**

Friend:

> "here's another one for you"
>
> "I have an array of DateTime objects, I want to match them up into groups of 4 that are the closest to each other"

Me:

> :thinking: _\*That's an interesting problem. Maybe put this in a little gem\*_

Later that night

Me:

> "Here is what I have so far..."

The algorithm to determine the closest neighbor is to look at the element before and after to determine which one is closer.

E.g.
Given the sequence

```plain
input:        1   5    20
               \ / \  /
separated by:   4   14
```

`1` and `5` (separated by 4) are closer together than `5` and `20` (separated by 14), so `5` is grouped with `1`

**groups:**

1. `1`, `5`
2. `20`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'closest_neighbours'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install closest_neighbours
```

## Usage

Require the gem

```ruby
require 'closest_neighbours'
```

Use the module:

```ruby
ClosestNeighbours.group(2, [1, 4, 3, 2])
# => [[1, 2], [3, 4]]
ClosestNeighbours.group(2, [10.days.ago, 9.days.ago, 1.day.ago])
# => [[10.days.ago, 9.days.ago], [1.day.ago]]
```

`ClosestNeighbours.ordered_group` allows you to squeeze additional performance out of the module by providing an ordered set of inputs. If in doubt, use `ClosestNeighbours.group`.

```ruby
ClosestNeighbours.ordered_group(2, [1, 2, 3, 4])
# => [[1, 2], [3, 4]]
```

## Development

### Setup

After checking out the repo, run setup to install dependencies.

```bash
bin/setup
```

### Testing

Then, to run the test suite.

```bash
bundle exec rake spec
```

To run tests when a file changes.

```bash
bundle exec guard
```

### Console

You can also run an interactive prompt that will allow you to experiment.

```bash
bin/console
```

### Install

To install this gem onto your local machine.

```bash
bundle exec rake install
```

### Release

To release a new version, update the version number in `version.rb`, and then run,

```bash
bundle exec rake release
```

This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

To experiment with that code, run `bin/console` for an interactive prompt.

Bug reports and pull requests are welcome on GitHub at <https://github.com/aussidavid/closest_neighbours>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ClosestNeighbours project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/closest_neighbours/blob/master/CODE_OF_CONDUCT.md).
