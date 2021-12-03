# Twee

[![Gem Version](https://badge.fury.io/rb/twee.svg)](https://badge.fury.io/rb/twee)

Simple tweet tool.

## Installation

Install from rubygems.org:

```
$ gem install twee
```

## Usage

### Setup

First, run `twee` command with no arguments. Display authorize URL. Access that URL and copy shown PIN code and paste it.

```
$ twee
Please access this URL      : https://twitter.com/oauth/authorize?oauth_token=xxxxxxxxxxxxxxxx
Please enter the PIN code   : 
```

Save configuration to `~/.twee.yml`.

### Tweet

```
$ twee message
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
