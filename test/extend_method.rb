require 'test/unit'
require 'extend_method'

class TestExtendMethod < Test::Unit::TestCase

  class Base
    attr_reader :val
    attr_accessor :attr
    def initialize val = nil
      @val = val
      @attr = nil
    end
    def set_val val
      @val = val
    end
    def get_val
      @val
    end
    def parent_method
      "bar"
    end
    def with_parent_method

    end
  end

  class Extended < Base
    class << self
      include ExtendMethod
    end
    extend_method :initialize do |value = nil|
      parent_method value ? "initialize:#{value}" : nil
    end
    extend_method :set_val do |value|
      parent_method "set:#{value}"
    end
    extend_method :attr= do |val|
      parent_method "attr:#{val}"
    end
    extend_method :get_val do
      "get:#{parent_method}"
    end
    extend_method :with_parent_method do
      has_parent_method?
    end
    extend_method :without_parent_method do
      has_parent_method?
    end
    extend_method :parent_method do
      "foo#{parent_method}"
    end
  end

  def test_extend_method
    val = 'test'
    base = Base.new
    assert base.val == nil
    base.set_val val
    assert base.val == val
    extended = Extended.new
    assert extended.val == nil
    extended.set_val val
    assert extended.val == "set:#{val}"
    assert extended.get_val == "get:set:#{val}"
  end

  def test_extend_method_initialize
    val = 'test'
    base = Base.new val
    assert base.val == val
    extended = Extended.new val
    assert extended.val == "initialize:#{val}"
  end

  def test_extend_method_attr_accessor
    val = 'test'
    base = Base.new
    assert base.attr == nil
    base.attr = val
    assert base.attr == val
    extended = Extended.new
    assert extended.attr == nil
    extended.attr = val
    assert extended.attr == "attr:#{val}"
  end

  def test_extend_method_has_parent_method?
    extended = Extended.new
    assert extended.with_parent_method
    assert !extended.without_parent_method
  end

  def test_extend_method_parent_method
    extended = Extended.new
    assert 'foobar' == extended.parent_method
  end

end