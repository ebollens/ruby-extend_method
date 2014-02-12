# extend_method

Dry and simple gem for method overriding in non-inheritance contexts.

## Status

This implementation is a **release candidate**.

[![Gem Version](https://badge.fury.io/rb/extend_method.png)](http://badge.fury.io/rb/extend_method) [![Code Climate](https://codeclimate.com/github/ebollens/ruby-extend_method.png)](https://codeclimate.com/github/ebollens/ruby-extend_method) [![Build Status](https://travis-ci.org/ebollens/ruby-extend_method.png)](https://travis-ci.org/ebollens/ruby-extend_method) [![Coverage Status](https://coveralls.io/repos/ebollens/ruby-extend_method/badge.png)](https://coveralls.io/r/ebollens/ruby-extend_method) [![Dependency Status](https://gemnasium.com/ebollens/ruby-extend_method.png)](https://gemnasium.com/ebollens/ruby-extend_method)

Please report issues in the [issue tracker](https://github.com/ebollens/ruby-extend_method/issues). [Pull requests](https://github.com/ebollens/ruby-extend_method/pulls) are welcome.

## License

The extend_method library is **open-source software** licensed under the BSD 3-clause license. The full text of the license may be found in the [LICENSE](https://github.com/ebollens/ruby-extend_method/blob/master/LICENSE) file.

## Credits

This library is written and maintained by Eric Bollens.

## Usage

Require the gem:

```ruby
require 'extend_method'
```

The `extend_method` class method can then be included as:

```ruby
class Example

  class << self
    include ExtendMethod
  end

end
```

A motivating example showing some of the major features:

```ruby
module Base

  def set val
    @val = val
  end

  def get
    @val
  end

end

class Extended

  include Base

  class << self
    include ExtendMethod
  end

  extend_method :set do |val|
    parent_method "#{val}!"
  end

  extend_method :get do
    "foo#{parent_method}"
  end

  extend_method :other do
    if has_parent_method?
      parent_method
    else
      # do something else
    end
  end

end

example = new Extended
example.set 'bar'
assert 'foobar!' == example.get
```

The `extend_method` class method takes a symbol for the method name and a block that extends the method, exposing the previous version of the method as `parent_method`:

```ruby
class Example

  def basic_example
    # ..
  end

  extend_method :basic_example do
    # ..
    val = parent_method
    # ..
  end

end
```

To determine if a parent method exists, use the `has_parent_method?` method:

```ruby
class Example

  extend_method :optional_parent_method_example do |*args|
    # ..
    parent_method(*args) if has_parent_method?
    # ..
  end

end
```

The block accepts arguments for what's passed to the method:

```ruby
class Example

  extend_method :argument_example do |val|
    "foo#{parent_method val}"
  end

end
```