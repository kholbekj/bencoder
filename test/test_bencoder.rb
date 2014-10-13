require 'minitest/autorun'
require 'bencoder'

class TestBencoder < Minitest::Unit::TestCase
  def setup
    @be = BEncoder
  end
  def test_string_encoding
    assert_equal '7:Someday', @be.encode('Someday')
  end

  def test_int_encoding
    assert_equal 'i123e', @be.encode(123)
  end

  def test_array_encoding
    assert_equal 'l3:hey5:theree', @be.encode(['hey', 'there'])
  end

  def test_hash_encoding
    assert_equal 'd4:what2:is2:up4:dawge', @be.encode({what: 'is', up: 'dawg'})
  end

  def test_nested_values
    assert_equal 'ld4:somel5:times3:youe5:gotta3:let2:go1:!ei2e5:wooooli1e1:21:3ee', @be.encode([{'some' => ['times', 'you'], gotta: 'let', go: '!'}, 2, "woooo", [1, '2', "3"]])
  end
end
