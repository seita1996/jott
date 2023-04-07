[![Test](https://github.com/seita1996/jott/actions/workflows/test.yml/badge.svg)](https://github.com/seita1996/jott/actions/workflows/test.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Gem](https://img.shields.io/gem/dt/jott?color=orange)

# Jott

A CLI application that allows you to create small memos.
It can be installed as a Ruby Gem, and you can create, delete and display memos with the jott command.

## Installation

```
$ gem install jott
```

## Usage

Create a new memo

```
$ jott add 'This is first memo'
```

List memos

```
$ jott ls
```

Delete the memo

```
$ jott rm 1
```

Clear all memos

```
$ jott clear
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seita1996/jott. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/seita1996/jott/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jott project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/seita1996/jott/blob/master/CODE_OF_CONDUCT.md).
