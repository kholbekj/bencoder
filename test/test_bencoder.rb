require 'coveralls'

Coveralls.wear!

require 'minitest/autorun'
require 'bencoder'

class TestBencoder < Minitest::Test

  def setup
    @be = BEncoder
  end

  #encoding

  def test_symbol_encoding
    assert_equal '6:hellou', @be.encode(:hellou)
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

  def test_nested_encoding
    assert_equal 'ld4:somel5:times3:youe5:gotta3:let2:go1:!ei2e5:wooooli1e1:21:3ee', @be.encode([{'some' => ['times', 'you'], gotta: 'let', go: '!'}, 2, "woooo", [1, '2', "3"]])
  end

  def test_should_not_encode_strange_types
    assert_raises UnencodableTypeError do
      @be.encode 5.6
    end
  end

  #decoding

  def test_string_decoding
    assert_equal "I'm free!", @be.decode("9:I'm free!")
  end

  def test_int_decoding
    assert_equal 321, @be.decode('i321e')
  end

  def test_array_decoding
    assert_equal ['1', 2, 3], @be.decode('l1:1i2ei3ee')
  end

  def test_hash_decoding
    assert_equal({'abc' => 'def', 'ghi' => 32}, @be.decode("d3:abc3:def3:ghii32ee"))
  end

  def test_nested_decoding
    assert_equal [{'some' => ['times', 'you'], 'gotta' => 'let', 'go' => '!'}, 2, "woooo", [1, '2', "3"]], @be.decode('ld4:somel5:times3:youe5:gotta3:let2:go1:!ei2e5:wooooli1e1:21:3ee')
  end

  def test_throws_error_on_wrong_list_encoding
    assert_raises InvalidEncodingError do
      @be.decode 'li4ed'
    end
  end

  def test_throws_error_on_wrong_dict_encoding
    assert_raises InvalidEncodingError do
      @be.decode 'd3:abc'
    end
  end

  def test_throws_error_on_wrong_int_encoding
    assert_raises InvalidEncodingError do
      @be.decode 'i14'
    end
  end

  def test_throws_error_on_wrong_string_encoding
    assert_raises InvalidEncodingError do
      @be.decode '4:cat'
    end
  end

  def test_throws_error_on_unknown_encoding_identifier
    assert_raises InvalidEncodingError do
      @be.decode 'li3ej5e'
    end
  end
end
