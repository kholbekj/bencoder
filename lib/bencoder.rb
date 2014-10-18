require 'stringio'
class BEncoder
  class << self
    def encode(object)
      case object
      when Symbol
        encode object.to_s
      when String
        encode_string object
      when Integer
        encode_int object
      when Array
        encode_array object
      when Hash
        encode_hash object
      end
    end

    def decode(string)    
      parse string
    end



    private

    def parse(string)
      case string[0]
      when 'i'
        parse_int string
      when 'l'
        parse_list string
      when 'd'
        parse_dict string
      else
        parse_string string
      end
    end

    def parse_list(string)
      if string.is_a? StringIO
        str = string
        str.getc if peek(str) == 'l'
      elsif string[0] == 'l' && string[-1] == 'e'
        str = StringIO.new string[1..-2]
      else 
        raise 'Not a list'
      end
      list = []
      until peek(str) == 'e' || str.eof?
        case peek(str)
        when 'i'
          list << parse_int(str.gets sep='e')
        when 'l'
          list << parse_list(str)
        when 'd'
          list << parse_dict(str)
        when ->(e) { e =~ /\d/ }
          length = str.gets(sep=':').to_i
          list << str.gets(length)
        else
          raise str.read
        end
      end
      str.getc
      list
    end

    def parse_dict(string)
      if string.is_a? StringIO
        string.getc if peek(string) == 'd'
        list_of_keys_and_values = parse_list(string)
      elsif string[0] == 'd' && string[-1] == 'e'
        list_of_keys_and_values = parse_list("l#{string[1..-2]}e")
      else
        raise 'Something in hash is wrong!'
      end
      hash = {}
      list_of_keys_and_values.each_slice(2) do |k,v|
        hash[k] = v
      end
      hash
    end

    def parse_int(string)
      if string[0] == 'i' && string[-1] == 'e'
        string[1..-2].to_i
      else
        raise 'Int is formatted wrong'
      end
    end

    def parse_string(string)
      length, content = string.split ':'
      if content.length == length.to_i
        content
      else
        raise 'String length is messed up'
      end
    end

    def encode_string(string)
      "#{string.length}:#{string}"
    end

    def encode_int(int)
      "i#{int}e"
    end

    def encode_array(array)
      array.inject("l") { |result, el| result += encode(el) } + "e"
    end

    def encode_hash(hash)
      hash.inject("d") { |result, (k,v)| result += "#{encode(k.to_s)}#{encode(v)}" } + 'e'
    end

    def peek(io)
      char = io.getc
      io.ungetc char
      puts char
      char
    end
  end
end